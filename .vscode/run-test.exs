#! /usr/bin/env elixir

defmodule TestRunner do
  def run(["all"]), do: cmd("mix", ["test"])

  def run(["open_active_file", root_path, open_file]) do
    open_file = String.replace_prefix(open_file, root_path <> "/", "")

    case find_test_target(open_file) do
      :not_found ->
        IO.puts("could not find test file for #{open_file}")

      test_target ->
        args = build_test_command_args(test_target)
        IO.puts("mix #{Enum.join(args, " ")}")

        cmd("mix", args)
    end
  end

  defp cmd(command, args),
    do: System.cmd(command, args, into: IO.stream(:stdio, :line), stderr_to_stdout: true)

  defp find_test_target(path) do
    case Path.split(path) do
      ["apps" | [app_name | rest]] ->
        app_root = Path.join(["apps", app_name])
        path = Path.join(rest)

        case guess_test_file(app_root, path) do
          :not_found -> :not_found
          found -> {app_name, found}
        end

      _ ->
        guess_test_file("", path)
    end
  end

  defp guess_test_file(root, path) do
    if String.ends_with?(path, "_test.exs") do
      path
    else
      [file | parent_paths] = path |> Path.split() |> Enum.reverse()

      from_lib_path =
        parent_paths |> Enum.take_while(fn dir -> dir != "lib" end) |> Enum.reverse()

      test_file_name = String.replace_suffix(file, ".ex", "_test.exs")
      test_path = Path.join(["test" | from_lib_path] ++ [test_file_name])

      if root |> Path.join(test_path) |> File.exists?() do
        test_path
      else
        :not_found
      end
    end
  end

  defp build_test_command_args({app_name, path}),
    do: ["cmd", "--app", app_name, "mix", "test", path]

  defp build_test_command_args(path), do: ["test", path]
end

System.argv() |> TestRunner.run()

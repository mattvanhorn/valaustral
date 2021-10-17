defmodule Valaustral.SuggestionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Valaustral.Suggestions` context.
  """

  @doc """
  Generate a suggestion.
  """
  def suggestion_fixture(attrs \\ %{}) do
    {:ok, suggestion} =
      attrs
      |> Enum.into(%{
        body: "some body",
        done: true,
        title: "some title"
      })
      |> Valaustral.Suggestions.create_suggestion()

    suggestion
  end
end

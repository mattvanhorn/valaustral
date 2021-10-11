defmodule Valaustral.HobbiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Valaustral.Hobbies` context.
  """

  @doc """
  Generate a hobby.
  """
  def hobby_fixture(attrs \\ %{}) do
    {:ok, hobby} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Valaustral.Hobbies.create_hobby()

    hobby
  end
end

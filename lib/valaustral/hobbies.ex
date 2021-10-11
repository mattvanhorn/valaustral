defmodule Valaustral.Hobbies do
  @moduledoc """
  The Hobbies context.
  """

  import Ecto.Query, warn: false
  alias Valaustral.Repo

  alias Valaustral.Hobbies.Hobby

  @doc """
  Returns the list of hobbies.

  ## Examples

      iex> list_hobbies(user)
      [%Hobby{}, ...]

  """
  def list_user_hobbies(user) do
    Hobby
    |> where(user_id: ^user.id)
    |> Repo.all()
  end

  @doc """
  Gets a single hobby.

  Raises `Ecto.NoResultsError` if the Hobby does not exist.

  ## Examples

      iex> get_hobby!(123)
      %Hobby{}

      iex> get_hobby!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hobby!(id), do: Repo.get!(Hobby, id)

  @doc """
  Creates a hobby.

  ## Examples

      iex> create_hobby(%{field: value})
      {:ok, %Hobby{}}

      iex> create_hobby(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hobby(attrs \\ %{}) do
    %Hobby{}
    |> Hobby.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hobby.

  ## Examples

      iex> update_hobby(hobby, %{field: new_value})
      {:ok, %Hobby{}}

      iex> update_hobby(hobby, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hobby(%Hobby{} = hobby, attrs) do
    hobby
    |> Hobby.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a hobby.

  ## Examples

      iex> delete_hobby(hobby)
      {:ok, %Hobby{}}

      iex> delete_hobby(hobby)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hobby(%Hobby{} = hobby) do
    Repo.delete(hobby)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hobby changes.

  ## Examples

      iex> change_hobby(hobby)
      %Ecto.Changeset{data: %Hobby{}}

  """
  def change_hobby(%Hobby{} = hobby, attrs \\ %{}) do
    Hobby.changeset(hobby, attrs)
  end
end

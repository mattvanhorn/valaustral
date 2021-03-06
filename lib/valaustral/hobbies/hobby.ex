defmodule Valaustral.Hobbies.Hobby do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "hobbies" do
    field :name, :string
    belongs_to :user, Valaustral.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(hobby, attrs \\ %{}) do
    hobby
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name])
    |> cast_or_constraint_assoc(:user)
  end

  defp cast_or_constraint_assoc(changeset, name) do
    {:assoc, %{owner_key: key}} = changeset.types[name]

    cond do
      changeset.changes[key] ->
        assoc_constraint(changeset, name)

      changeset.changes[name] ->
        cast_assoc(changeset, name, required: true)

      true ->
        changeset
    end
  end
end

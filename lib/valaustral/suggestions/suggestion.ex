defmodule Valaustral.Suggestions.Suggestion do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "suggestions" do
    field :body, :string
    field :done, :boolean, default: false
    field :title, :string
    belongs_to :author, Valaustral.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(suggestion, attrs) do
    suggestion
    |> cast(attrs, [:author_id, :title, :body, :done])
    |> validate_required([:title, :body, :done])
    |> cast_or_constraint_assoc(:author)
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

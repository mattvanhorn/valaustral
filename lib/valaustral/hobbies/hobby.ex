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
  def changeset(hobby, attrs) do
    hobby
    |> cast(attrs, [:name, :user_id])
    |> cast_assoc(:user)
    |> validate_required([:name])
  end
end

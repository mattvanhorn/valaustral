defmodule Valaustral.Repo.Migrations.CreateHobbies do
  use Ecto.Migration

  def change do
    create table(:hobbies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:hobbies, [:user_id])
  end
end

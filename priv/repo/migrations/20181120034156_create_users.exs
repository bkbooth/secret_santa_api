defmodule SecretSanta.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :password_hash, :string
      add :phone_number, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:phone_number])
  end
end

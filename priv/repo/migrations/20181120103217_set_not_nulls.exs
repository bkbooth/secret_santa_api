defmodule SecretSanta.Repo.Migrations.SetNotNulls do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :name, :string, null: false
      modify :email, :string, null: false
      modify :password_hash, :string, null: false
    end

    alter table(:gift_groups) do
      modify :code, :string, null: false
      modify :name, :string, null: false
    end

    alter table(:gifters) do
      modify :name, :string, null: false
    end
  end
end

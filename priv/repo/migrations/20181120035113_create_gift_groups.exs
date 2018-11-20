defmodule SecretSanta.Repo.Migrations.CreateGiftGroups do
  use Ecto.Migration

  def change do
    create table(:gift_groups, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :code, :string
      add :name, :string
      add :description, :text
      add :rules, {:array, :string}

      add :owner_id,
          references(:users, on_delete: :delete_all, type: :binary_id),
          null: false

      timestamps()
    end

    create unique_index(:gift_groups, [:code])
    create index(:gift_groups, [:owner_id])
  end
end

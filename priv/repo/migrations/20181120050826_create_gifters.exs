defmodule SecretSanta.Repo.Migrations.CreateGifters do
  use Ecto.Migration

  def change do
    create table(:gifters, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :phone_number, :string

      add :gift_group_id,
          references(:gift_groups, on_delete: :delete_all, type: :binary_id),
          null: false

      add :user_id, references(:users, on_delete: :nilify_all, type: :binary_id)
      add :giftee_id, references(:gifters, on_delete: :nilify_all, type: :binary_id)

      timestamps()
    end

    create unique_index(:gifters, [:id, :email])
    create unique_index(:gifters, [:id, :phone_number])
    create index(:gifters, [:gift_group_id])
    create index(:gifters, [:user_id])
    create index(:gifters, [:giftee_id])
  end
end

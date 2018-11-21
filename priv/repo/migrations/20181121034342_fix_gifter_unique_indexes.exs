defmodule SecretSanta.Repo.Migrations.FixGifterUniqueIndexes do
  use Ecto.Migration

  def change do
    drop unique_index(:gifters, [:id, :email])
    drop unique_index(:gifters, [:id, :phone_number])

    create unique_index(:gifters, [:gift_group_id, :email])
    create unique_index(:gifters, [:gift_group_id, :phone_number])
  end
end

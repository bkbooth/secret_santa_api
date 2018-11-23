defmodule SecretSanta.Repo.Migrations.CreateGiftersExclusions do
  use Ecto.Migration

  def change do
    create table(:gifters_exclusions, primary_key: false) do
      add :gifter_id,
          references(:gifters, on_delete: :delete_all, type: :binary_id),
          null: false
      add :giftee_id,
          references(:gifters, on_delete: :delete_all, type: :binary_id),
          null: false
    end

    create unique_index(:gifters_exclusions, [:gifter_id, :giftee_id])
  end
end

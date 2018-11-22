defmodule SecretSanta.Repo.Migrations.AddDrawnToGiftGroup do
  use Ecto.Migration

  def change do
    alter table(:gift_groups) do
      add :drawn, :boolean, null: false, default: false
    end
  end
end

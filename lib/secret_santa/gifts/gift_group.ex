defmodule SecretSanta.Gifts.GiftGroup do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "gift_groups" do
    field :code, :string
    field :description, :string
    field :name, :string
    field :rules, {:array, :string}

    belongs_to :user,
               SecretSanta.Accounts.User,
               foreign_key: :owner_id

    timestamps()
  end

  @doc false
  def changeset(gift_group, attrs) do
    gift_group
    |> cast(attrs, [:code, :name, :description, :rules])
    |> validate_required([:code, :name])
    |> unique_constraint(:code)
  end
end

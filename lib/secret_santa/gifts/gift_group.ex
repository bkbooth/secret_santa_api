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
    field :drawn, :boolean, default: false

    belongs_to :owner, SecretSanta.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(gift_group, attrs) do
    gift_group
    |> cast(attrs, [:name, :description, :rules])
    |> validate_required([:name])
  end

  @doc false
  def create_changeset(gift_group, attrs) do
    gift_group
    |> changeset(attrs)
    |> cast_assoc(:owner)
    |> put_code()
  end

  defp put_code(%Ecto.Changeset{valid?: true} = changeset) do
    code =
      Ecto.UUID.generate()
      |> String.split("-")
      |> hd

    put_change(changeset, :code, code)
  end

  defp put_code(changeset), do: changeset
end

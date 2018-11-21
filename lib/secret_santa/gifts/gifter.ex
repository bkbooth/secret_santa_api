defmodule SecretSanta.Gifts.Gifter do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "gifters" do
    field :email, :string
    field :name, :string
    field :phone_number, :string

    belongs_to :gift_group, SecretSanta.Gifts.GiftGroup
    belongs_to :giftee, SecretSanta.Gifts.Gifter
    belongs_to :user, SecretSanta.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(gifter, attrs) do
    gifter
    |> cast(attrs, [:name, :email, :phone_number, :giftee_id, :user_id])
    |> validate_required([:name])
    |> validate_any_required([:email, :phone_number])
    |> validate_format(:email, ~r/@/)
    |> foreign_key_constraint(:giftee_id)
    |> cast_assoc(:giftee)
    |> foreign_key_constraint(:user_id)
    |> cast_assoc(:user)
  end

  @doc false
  def create_changeset(gifter, attrs) do
    gifter
    |> changeset(attrs)
    |> cast_assoc(:gift_group)
  end

  def validate_any_required(changeset, fields) do
    if Enum.any?(fields, &present?(changeset, &1)) do
      changeset
    else
      Enum.reduce(fields, changeset, fn field, changeset ->
        add_error(changeset, field, "either #{Enum.join(fields, " or ")} is required")
      end)
    end
  end

  defp present?(changeset, field) do
    value = get_field(changeset, field)
    value && String.trim(value) != ""
  end
end

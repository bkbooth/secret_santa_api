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
    |> cast(attrs, [:name, :email, :phone_number, :gift_group_id, :giftee_id, :user_id])
    |> validate_required([:name, :gift_group_id])
    |> validate_email_or_phone_number()
  end

  def validate_email_or_phone_number(changeset) do
    if present?(changeset, :email) || present?(changeset, :phone_number) do
      changeset
    else
      changeset
      |> add_error(:email, "either email or phone number is required")
      |> add_error(:phone_number, "either email or phone number is required")
    end
  end

  defp present?(changeset, field) do
    value = get_field(changeset, field)
    value && value != ""
  end
end

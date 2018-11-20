defmodule SecretSanta.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :phone_number, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash, :phone_number])
    |> validate_required([:name, :email, :password_hash])
    |> unique_constraint(:email)
    |> unique_constraint(:phone_number)
  end
end

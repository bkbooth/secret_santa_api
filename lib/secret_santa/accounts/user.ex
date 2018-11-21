defmodule SecretSanta.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Comeonin.Bcrypt

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :email, :string
    field :phone_number, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :phone_number])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:phone_number)
  end

  @doc false
  def password_changeset(user, attrs) do
    user
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 8)
    |> put_password_hash()
  end

  @doc false
  def create_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> password_changeset(attrs)
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: pwd}} = changeset) do
    change(changeset, Bcrypt.add_hash(pwd))
  end

  defp put_password_hash(changeset), do: changeset
end

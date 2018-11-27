defmodule SecretSanta.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias Comeonin.Bcrypt
  alias SecretSanta.Repo
  alias SecretSanta.Accounts.{User}

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user by email address.

  ## Examples

      iex> get_user_by_email("user@example.com")
      %User{}

      iex> get_user_by_email("unknown@example.com")
      nil

  """
  def get_user_by_email(email) do
    from(u in User, where: u.email == ^email)
    |> Repo.one()
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Authenticate a user by email and password.

      iex> authenticate_by_email_and_password("user@example.com", "password123")
      {:ok, %User{}}

      iex> authenticate_by_email_and_password("user@example.com", "invalid123")
      {:error, :unauthorized}

      iex> authenticate_by_email_and_password("unknown@example.com", "password123")
      {:error, :not_found}

  """
  def authenticate_by_email_and_password(email, password) do
    with %User{} = user <- get_user_by_email(email),
         :ok <- verify_password(password, user.password_hash) do
      {:ok, user}
    else
      nil ->
        Bcrypt.dummy_checkpw()
        {:error, :not_found}

      _ ->
        {:error, :unauthorized}
    end
  end

  defp verify_password(password, password_hash) do
    if Bcrypt.checkpw(password, password_hash) do
      :ok
    else
      {:error, :invalid_password}
    end
  end
end

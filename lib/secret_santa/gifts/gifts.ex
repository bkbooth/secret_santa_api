defmodule SecretSanta.Gifts do
  @moduledoc """
  The Gifts context.
  """

  import Ecto.Query, warn: false

  alias SecretSanta.Repo
  alias SecretSanta.Accounts.User
  alias SecretSanta.Gifts.GiftGroup
  alias SecretSanta.Gifts.Gifter

  @doc """
  Returns the list of gift_groups for a given user.

  ## Examples

      iex> list_user_gift_groups(user)
      [%GiftGroup{}, ...]

  """
  def list_user_gift_groups(%User{} = user) do
    GiftGroup
    |> user_gift_groups_query(user)
    |> Repo.all()
  end

  @doc """
  Gets a single gift_group.

  Raises `Ecto.NoResultsError` if the Gift group does not exist.

  ## Examples

      iex> get_gift_group!(123)
      %GiftGroup{}

      iex> get_gift_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gift_group!(id), do: Repo.get!(GiftGroup, id)

  @doc """
  Gets a single gift_group for a given user.

  Raises `Ecto.NoResultsError` if the Gift group does not exist or if the user isn't the owner.

  ## Examples

      iex> get_user_gift_group!(owner, 123)
      %GiftGroup{}

      iex> get_user_gift_group!(owner, 456)
      ** (Ecto.NoResultsError)

      iex> get_user_gift_group!(non_owner, 123)
      ** (Ecto.NoResultsError)

  """
  def get_user_gift_group!(%User{} = user, id) do
    from(p in GiftGroup, where: p.id == ^id)
    |> user_gift_groups_query(user)
    |> Repo.one!()
  end

  @doc """
  Creates a gift_group.

  ## Examples

      iex> create_gift_group(user, %{field: value})
      {:ok, %GiftGroup{}}

      iex> create_gift_group(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gift_group(%User{} = user, attrs \\ %{}) do
    %GiftGroup{}
    |> GiftGroup.create_changeset(attrs)
    |> Ecto.Changeset.put_assoc(:owner, user)
    |> Repo.insert()
  end

  @doc """
  Updates a gift_group.

  ## Examples

      iex> update_gift_group(gift_group, %{field: new_value})
      {:ok, %GiftGroup{}}

      iex> update_gift_group(gift_group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gift_group(%GiftGroup{} = gift_group, attrs) do
    gift_group
    |> GiftGroup.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a GiftGroup.

  ## Examples

      iex> delete_gift_group(gift_group)
      {:ok, %GiftGroup{}}

      iex> delete_gift_group(gift_group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gift_group(%GiftGroup{} = gift_group) do
    Repo.delete(gift_group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gift_group changes.

  ## Examples

      iex> change_gift_group(gift_group)
      %Ecto.Changeset{source: %GiftGroup{}}

  """
  def change_gift_group(%GiftGroup{} = gift_group) do
    GiftGroup.changeset(gift_group, %{})
  end

  defp user_gift_groups_query(query, %User{id: user_id}) do
    from(p in query, where: p.owner_id == ^user_id)
  end

  @doc """
  Returns the list of gifters for a given gift_group.

  ## Examples

      iex> list_gift_group_gifters(gift_group)
      [%Gifter{}, ...]

  """
  def list_gift_group_gifters(%GiftGroup{} = gift_group) do
    Gifter
    |> gift_group_gifters_query(gift_group)
    |> Repo.all()
  end

  @doc """
  Gets a single gifter.

  Raises `Ecto.NoResultsError` if the Gifter does not exist.

  ## Examples

      iex> get_gifter!(123)
      %Gifter{}

      iex> get_gifter!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gifter!(id), do: Repo.get!(Gifter, id)

  @doc """
  Creates a gifter.

  ## Examples

      iex> create_gifter(gift_group, %{field: value})
      {:ok, %Gifter{}}

      iex> create_gifter(gift_group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gifter(%GiftGroup{} = gift_group, attrs \\ %{}) do
    %Gifter{}
    |> Gifter.create_changeset(attrs)
    |> Ecto.Changeset.put_assoc(:gift_group, gift_group)
    |> put_gifter_exclusions(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gifter.

  ## Examples

      iex> update_gifter(gifter, %{field: new_value})
      {:ok, %Gifter{}}

      iex> update_gifter(gifter, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gifter(%Gifter{} = gifter, attrs) do
    gifter
    |> Gifter.changeset(attrs)
    |> put_gifter_exclusions(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Gifter.

  ## Examples

      iex> delete_gifter(gifter)
      {:ok, %Gifter{}}

      iex> delete_gifter(gifter)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gifter(%Gifter{} = gifter) do
    Repo.delete(gifter)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gifter changes.

  ## Examples

      iex> change_gifter(gifter)
      %Ecto.Changeset{source: %Gifter{}}

  """
  def change_gifter(%Gifter{} = gifter) do
    Gifter.changeset(gifter, %{})
  end

  defp gift_group_gifters_query(query, %GiftGroup{id: gift_group_id}) do
    from(p in query, where: p.gift_group_id == ^gift_group_id)
  end

  defp put_gifter_exclusions(changeset, attrs) do
    case Map.get(attrs, :exclusions, []) do
      [] ->
        changeset

      exclusion_ids ->
        gifters = Repo.all(from g in Gifter, where: g.id in ^exclusion_ids)
        Ecto.Changeset.put_assoc(changeset, :exclusions, gifters)
    end
  end
end

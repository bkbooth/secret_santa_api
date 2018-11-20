defmodule SecretSanta.Gifts do
  @moduledoc """
  The Gifts context.
  """

  import Ecto.Query, warn: false
  alias SecretSanta.Repo
  alias SecretSanta.Gifts.GiftGroup
  alias SecretSanta.Gifts.Gifter

  @doc """
  Returns the list of gift_groups.

  ## Examples

      iex> list_gift_groups()
      [%GiftGroup{}, ...]

  """
  def list_gift_groups do
    Repo.all(GiftGroup)
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
  Creates a gift_group.

  ## Examples

      iex> create_gift_group(%{field: value})
      {:ok, %GiftGroup{}}

      iex> create_gift_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gift_group(attrs \\ %{}) do
    %GiftGroup{}
    |> GiftGroup.changeset(attrs)
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

  @doc """
  Returns the list of gifters.

  ## Examples

      iex> list_gifters()
      [%Gifter{}, ...]

  """
  def list_gifters do
    Repo.all(Gifter)
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

      iex> create_gifter(%{field: value})
      {:ok, %Gifter{}}

      iex> create_gifter(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gifter(attrs \\ %{}) do
    %Gifter{}
    |> Gifter.changeset(attrs)
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
end

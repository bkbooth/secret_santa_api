defmodule SecretSanta.Gifts do
  @moduledoc """
  The Gifts context.
  """

  import Ecto.Query, warn: false
  alias SecretSanta.Repo

  alias SecretSanta.Gifts.GiftGroup

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
end

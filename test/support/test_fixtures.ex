defmodule SecretSanta.TestFixtures do
  alias SecretSanta.{Accounts, Gifts}

  def valid_user do
    %{
      name: "Test User",
      email: "#{unique_username()}@example.com",
      password_hash: "password123",
      phone_number: "#{System.unique_integer([:positive])}"
    }
  end

  def invalid_user do
    %{name: nil, email: nil, password_hash: nil}
  end

  def user_fixture(attrs \\ %{}) do
    attrs = Enum.into(valid_user(), attrs)

    with {:ok, user} <- Accounts.create_user(attrs) do
      user
    end
  end

  def valid_gift_group do
    %{
      name: "Test Gift Group",
      description: "A description for the Test Gift Group",
      rules: ["Anything goes!"]
    }
  end

  def invalid_gift_group do
    %{name: nil}
  end

  def gift_group_fixture(%Accounts.User{} = owner, attrs \\ %{}) do
    attrs = Enum.into(valid_gift_group(), attrs)

    with {:ok, gift_group} <- Gifts.create_gift_group(owner, attrs) do
      gift_group
    end
  end

  def valid_gifter do
    %{
      name: "Test Gifter",
      email: "#{unique_username()}@example.com"
    }
  end

  def invalid_gifter do
    %{name: nil, email: nil}
  end

  def gifter_fixture(%Gifts.GiftGroup{} = gift_group, attrs \\ %{}) do
    attrs = Enum.into(valid_gifter(), attrs)

    with {:ok, gifter} <- Gifts.create_gifter(gift_group, attrs) do
      gifter
    end
  end

  defp unique_username do
    "user#{System.unique_integer([:positive])}"
  end
end

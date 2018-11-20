defmodule SecretSanta.GiftsTest do
  use SecretSanta.DataCase

  alias SecretSanta.Gifts

  def owner_fixture do
    {:ok, user} =
      SecretSanta.Accounts.create_user(%{
        email: "foo@example.com",
        name: "foo bar",
        password_hash: "password123"
      })

    user
  end

  describe "gift_groups" do
    alias SecretSanta.Gifts.GiftGroup

    @valid_attrs %{
      code: "c0d3",
      description: "a description of my gift group",
      name: "my gift group",
      rules: ["anything goes"]
    }
    @update_attrs %{
      code: "c0d3z",
      description: "a description of our gift group",
      name: "our gift group",
      rules: ["almost anything goes"]
    }
    @invalid_attrs %{code: nil, description: nil, name: nil, rules: nil}

    def gift_group_fixture(attrs \\ %{}) do
      owner = owner_fixture()

      {:ok, gift_group} =
        %{owner_id: owner.id}
        |> Enum.into(attrs)
        |> Enum.into(@valid_attrs)
        |> Gifts.create_gift_group()

      gift_group
    end

    test "list_gift_groups/0 returns all gift_groups" do
      gift_group = gift_group_fixture()
      assert Gifts.list_gift_groups() == [gift_group]
    end

    test "get_gift_group!/1 returns the gift_group with given id" do
      gift_group = gift_group_fixture()
      assert Gifts.get_gift_group!(gift_group.id) == gift_group
    end

    test "create_gift_group/1 with valid data creates a gift_group" do
      owner = owner_fixture()
      attrs = Enum.into(%{owner_id: owner.id}, @valid_attrs)
      assert {:ok, %GiftGroup{} = gift_group} = Gifts.create_gift_group(attrs)
      assert gift_group.code == "c0d3"
      assert gift_group.description == "a description of my gift group"
      assert gift_group.name == "my gift group"
      assert gift_group.rules == ["anything goes"]
      assert gift_group.owner_id == owner.id
    end

    test "create_gift_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Gifts.create_gift_group(@invalid_attrs)
    end

    test "update_gift_group/2 with valid data updates the gift_group" do
      gift_group = gift_group_fixture()
      assert {:ok, %GiftGroup{} = gift_group} = Gifts.update_gift_group(gift_group, @update_attrs)
      assert gift_group.code == "c0d3z"
      assert gift_group.description == "a description of our gift group"
      assert gift_group.name == "our gift group"
      assert gift_group.rules == ["almost anything goes"]
    end

    test "update_gift_group/2 with invalid data returns error changeset" do
      gift_group = gift_group_fixture()
      assert {:error, %Ecto.Changeset{}} = Gifts.update_gift_group(gift_group, @invalid_attrs)
      assert gift_group == Gifts.get_gift_group!(gift_group.id)
    end

    test "delete_gift_group/1 deletes the gift_group" do
      gift_group = gift_group_fixture()
      assert {:ok, %GiftGroup{}} = Gifts.delete_gift_group(gift_group)
      assert_raise Ecto.NoResultsError, fn -> Gifts.get_gift_group!(gift_group.id) end
    end

    test "change_gift_group/1 returns a gift_group changeset" do
      gift_group = gift_group_fixture()
      assert %Ecto.Changeset{} = Gifts.change_gift_group(gift_group)
    end
  end

  describe "gifters" do
    alias SecretSanta.Gifts.Gifter

    @valid_attrs %{email: "foo@example.com", name: "foo bar", phone_number: "0123456789"}
    @update_attrs %{
      email: "bar@example.com",
      name: "bar baz",
      phone_number: "0987654321"
    }
    @invalid_attrs %{email: nil, name: nil, phone_number: nil}

    def gifter_fixture(attrs \\ %{}) do
      gift_group = gift_group_fixture()

      {:ok, gifter} =
        %{gift_group_id: gift_group.id}
        |> Enum.into(attrs)
        |> Enum.into(@valid_attrs)
        |> Gifts.create_gifter()

      gifter
    end

    test "list_gifters/0 returns all gifters" do
      gifter = gifter_fixture()
      assert Gifts.list_gifters() == [gifter]
    end

    test "get_gifter!/1 returns the gifter with given id" do
      gifter = gifter_fixture()
      assert Gifts.get_gifter!(gifter.id) == gifter
    end

    test "create_gifter/1 with valid data creates a gifter" do
      gift_group = gift_group_fixture()
      attrs = Enum.into(%{gift_group_id: gift_group.id}, @valid_attrs)
      assert {:ok, %Gifter{} = gifter} = Gifts.create_gifter(attrs)
      assert gifter.email == "foo@example.com"
      assert gifter.name == "foo bar"
      assert gifter.phone_number == "0123456789"
    end

    test "create_gifter/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Gifts.create_gifter(@invalid_attrs)
    end

    test "update_gifter/2 with valid data updates the gifter" do
      gifter = gifter_fixture()
      assert {:ok, %Gifter{} = gifter} = Gifts.update_gifter(gifter, @update_attrs)
      assert gifter.email == "bar@example.com"
      assert gifter.name == "bar baz"
      assert gifter.phone_number == "0987654321"
    end

    test "update_gifter/2 with invalid data returns error changeset" do
      gifter = gifter_fixture()
      assert {:error, %Ecto.Changeset{}} = Gifts.update_gifter(gifter, @invalid_attrs)
      assert gifter == Gifts.get_gifter!(gifter.id)
    end

    test "delete_gifter/1 deletes the gifter" do
      gifter = gifter_fixture()
      assert {:ok, %Gifter{}} = Gifts.delete_gifter(gifter)
      assert_raise Ecto.NoResultsError, fn -> Gifts.get_gifter!(gifter.id) end
    end

    test "change_gifter/1 returns a gifter changeset" do
      gifter = gifter_fixture()
      assert %Ecto.Changeset{} = Gifts.change_gifter(gifter)
    end
  end
end

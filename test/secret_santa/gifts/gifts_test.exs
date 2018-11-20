defmodule SecretSanta.GiftsTest do
  use SecretSanta.DataCase

  alias SecretSanta.Gifts

  describe "gift_groups" do
    alias SecretSanta.Gifts.GiftGroup

    @valid_attrs %{
      code: "some code",
      description: "some description",
      name: "some name",
      rules: []
    }
    @update_attrs %{
      code: "some updated code",
      description: "some updated description",
      name: "some updated name",
      rules: []
    }

    @invalid_attrs %{code: nil, description: nil, name: nil, rules: nil}

    def gift_group_fixture(attrs \\ %{}) do
      {:ok, gift_group} =
        attrs
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
      assert {:ok, %GiftGroup{} = gift_group} = Gifts.create_gift_group(@valid_attrs)
      assert gift_group.code == "some code"
      assert gift_group.description == "some description"
      assert gift_group.name == "some name"
      assert gift_group.rules == []
    end

    test "create_gift_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Gifts.create_gift_group(@invalid_attrs)
    end

    test "update_gift_group/2 with valid data updates the gift_group" do
      gift_group = gift_group_fixture()
      assert {:ok, %GiftGroup{} = gift_group} = Gifts.update_gift_group(gift_group, @update_attrs)
      assert gift_group.code == "some updated code"
      assert gift_group.description == "some updated description"
      assert gift_group.name == "some updated name"
      assert gift_group.rules == []
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
end

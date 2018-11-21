defmodule SecretSanta.GiftsTest do
  use SecretSanta.DataCase

  alias SecretSanta.Repo
  alias SecretSanta.Gifts
  alias SecretSanta.Gifts.{GiftGroup, Gifter}

  setup _ do
    {:ok, owner: user_fixture()}
  end

  test "create_gift_group/1 with valid data creates a gift_group", %{owner: owner} do
    assert {:ok, %GiftGroup{} = gift_group} = Gifts.create_gift_group(owner, valid_gift_group())
    assert gift_group.code =~ ~r/^[a-z0-9]+$/
    assert gift_group.name == "Test Gift Group"
    assert gift_group.description == "A description for the Test Gift Group"
    assert gift_group.rules == ["Anything goes!"]
  end

  test "create_gift_group/1 with invalid data returns error changeset", %{owner: owner} do
    assert {:error, %Ecto.Changeset{}} = Gifts.create_gift_group(owner, invalid_gift_group())
  end

  describe "with existing gift_groups" do
    setup %{owner: owner} do
      other_user = user_fixture()

      {:ok,
       gift_group: gift_group_fixture(owner), other_gift_group: gift_group_fixture(other_user)}
    end

    test "list_user_gift_groups/1 returns all gift_groups for a user", %{
      gift_group: gift_group,
      owner: owner
    } do
      user_gift_groups = Gifts.list_user_gift_groups(owner) |> Repo.preload(:owner)
      assert length(user_gift_groups) == 1
      assert List.first(user_gift_groups) == gift_group
    end

    test "get_gift_group!/1 returns the gift_group with given id", %{gift_group: gift_group} do
      assert Gifts.get_gift_group!(gift_group.id) |> Repo.preload(:owner) == gift_group
    end

    test "get_user_gift_group!/2 returns the gift_group if the user is the owner", %{
      gift_group: gift_group,
      owner: owner
    } do
      assert gift_group ==
               Gifts.get_user_gift_group!(owner, gift_group.id) |> Repo.preload(:owner)
    end

    test "get_user_gift_group!/2 raises error if the user is not the owner", %{
      other_gift_group: gift_group,
      owner: owner
    } do
      assert_raise Ecto.NoResultsError, fn ->
        Gifts.get_user_gift_group!(owner, gift_group.id)
      end
    end

    test "update_gift_group/2 with valid data updates the gift_group", %{
      gift_group: %GiftGroup{id: id} = gift_group
    } do
      attrs = %{name: "Updated Gift Group"}
      assert {:ok, %GiftGroup{} = gift_group} = Gifts.update_gift_group(gift_group, attrs)
      assert gift_group.id == id
      assert gift_group.name == "Updated Gift Group"
    end

    test "update_gift_group/2 with invalid data returns error changeset", %{
      gift_group: gift_group
    } do
      assert {:error, %Ecto.Changeset{}} =
               Gifts.update_gift_group(gift_group, invalid_gift_group())

      assert gift_group == Gifts.get_gift_group!(gift_group.id) |> Repo.preload(:owner)
    end

    test "delete_gift_group/1 deletes the gift_group", %{gift_group: gift_group} do
      assert {:ok, %GiftGroup{}} = Gifts.delete_gift_group(gift_group)
      assert_raise Ecto.NoResultsError, fn -> Gifts.get_gift_group!(gift_group.id) end
    end

    test "change_gift_group/1 returns a gift_group changeset", %{gift_group: gift_group} do
      assert %Ecto.Changeset{} = Gifts.change_gift_group(gift_group)
    end

    test "create_gifter/1 with valid data creates a gifter", %{gift_group: gift_group} do
      assert {:ok, %Gifter{} = gifter} = Gifts.create_gifter(gift_group, valid_gifter())
      assert gifter.name == "Test Gifter"
      assert gifter.email =~ ~r/^user\d+@example\.com$/
    end

    test "create_gifter/1 with invalid data returns error changeset", %{gift_group: gift_group} do
      assert {:error, %Ecto.Changeset{}} = Gifts.create_gifter(gift_group, invalid_gifter())
    end

    test "create_gifter/1 requires either email or phone_number", %{gift_group: gift_group} do
      attrs = %{email: nil, phone_number: nil} |> Enum.into(valid_gifter())
      {:error, %Ecto.Changeset{} = changeset} = Gifts.create_gifter(gift_group, attrs)

      assert changeset.errors == [
               phone_number: {"either email or phone_number is required", []},
               email: {"either email or phone_number is required", []}
             ]
    end
  end

  describe "with existing gifters" do
    setup %{owner: owner} do
      gift_group = gift_group_fixture(owner)
      other_gift_group = gift_group_fixture(owner)

      {:ok,
       gift_group: gift_group,
       gifter: gifter_fixture(gift_group),
       other_gifter: gifter_fixture(other_gift_group)}
    end

    test "list_gift_group_gifters/1 returns all gifters for a gift_group", %{
      gifter: gifter,
      gift_group: gift_group
    } do
      gift_group_gifters =
        Gifts.list_gift_group_gifters(gift_group) |> Repo.preload(gift_group: [:owner])

      assert length(gift_group_gifters) == 1
      assert List.first(gift_group_gifters) == gifter
    end

    test "get_gifter!/1 returns the gifter with given id", %{gifter: gifter} do
      assert gifter == Gifts.get_gifter!(gifter.id) |> Repo.preload(gift_group: [:owner])
    end

    test "update_gifter/2 with valid data updates the gifter", %{gifter: %Gifter{id: id} = gifter} do
      attrs = %{name: "Updated Gifter"}
      assert {:ok, %Gifter{} = gifter} = Gifts.update_gifter(gifter, attrs)
      assert gifter.id == id
      assert gifter.name == "Updated Gifter"
    end

    test "update_gifter/2 with invalid data returns error changeset", %{gifter: gifter} do
      assert {:error, %Ecto.Changeset{}} = Gifts.update_gifter(gifter, invalid_gifter())
      assert gifter == Gifts.get_gifter!(gifter.id) |> Repo.preload(gift_group: [:owner])
    end

    test "delete_gifter/1 deletes the gifter", %{gifter: gifter} do
      assert {:ok, %Gifter{}} = Gifts.delete_gifter(gifter)
      assert_raise Ecto.NoResultsError, fn -> Gifts.get_gifter!(gifter.id) end
    end

    test "change_gifter/1 returns a gifter changeset", %{gifter: gifter} do
      assert %Ecto.Changeset{} = Gifts.change_gifter(gifter)
    end
  end
end

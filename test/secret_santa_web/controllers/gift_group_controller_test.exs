defmodule SecretSantaWeb.GiftGroupControllerTest do
  use SecretSantaWeb.ConnCase

  alias SecretSanta.Gifts
  alias SecretSanta.Gifts.GiftGroup

  @create_attrs %{
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

  def fixture(:gift_group) do
    {:ok, gift_group} = Gifts.create_gift_group(@create_attrs)
    gift_group
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all gift_groups", %{conn: conn} do
      conn = get(conn, Routes.gift_group_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create gift_group" do
    test "renders gift_group when data is valid", %{conn: conn} do
      conn = post(conn, Routes.gift_group_path(conn, :create), gift_group: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.gift_group_path(conn, :show, id))

      assert %{
               "id" => id,
               "code" => "some code",
               "description" => "some description",
               "name" => "some name",
               "rules" => []
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.gift_group_path(conn, :create), gift_group: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update gift_group" do
    setup [:create_gift_group]

    test "renders gift_group when data is valid", %{
      conn: conn,
      gift_group: %GiftGroup{id: id} = gift_group
    } do
      conn =
        put(conn, Routes.gift_group_path(conn, :update, gift_group), gift_group: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.gift_group_path(conn, :show, id))

      assert %{
               "id" => id,
               "code" => "some updated code",
               "description" => "some updated description",
               "name" => "some updated name",
               "rules" => []
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, gift_group: gift_group} do
      conn =
        put(conn, Routes.gift_group_path(conn, :update, gift_group), gift_group: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete gift_group" do
    setup [:create_gift_group]

    test "deletes chosen gift_group", %{conn: conn, gift_group: gift_group} do
      conn = delete(conn, Routes.gift_group_path(conn, :delete, gift_group))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.gift_group_path(conn, :show, gift_group))
      end
    end
  end

  defp create_gift_group(_) do
    gift_group = fixture(:gift_group)
    {:ok, gift_group: gift_group}
  end
end

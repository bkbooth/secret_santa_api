defmodule SecretSantaWeb.GifterControllerTest do
  use SecretSantaWeb.ConnCase

  alias SecretSanta.Gifts
  alias SecretSanta.Gifts.Gifter

  @create_attrs %{
    email: "foo@example.com",
    name: "foo bar",
    phone_number: "0123456789"
  }
  @update_attrs %{
    email: "bar@example.com",
    name: "bar baz",
    phone_number: "0987654321"
  }
  @invalid_attrs %{email: nil, name: nil, phone_number: nil}

  def owner_fixture do
    {:ok, user} =
      SecretSanta.Accounts.create_user(%{
        email: "foo@example.com",
        name: "foo bar",
        password_hash: "password123"
      })

    user
  end

  def gift_group_fixture do
    owner = owner_fixture()

    {:ok, gift_group} =
      Gifts.create_gift_group(%{
        code: "c0d3",
        name: "my gift group",
        owner_id: owner.id
      })

    gift_group
  end

  def fixture(:gifter) do
    gift_group = gift_group_fixture()

    {:ok, gifter} =
      %{gift_group_id: gift_group.id}
      |> Enum.into(@create_attrs)
      |> Gifts.create_gifter()

    gifter
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all gifters", %{conn: conn} do
      conn = get(conn, Routes.gifter_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create gifter" do
    test "renders gifter when data is valid", %{conn: conn} do
      gift_group = gift_group_fixture()
      attrs = Enum.into(%{gift_group_id: gift_group.id}, @create_attrs)
      conn = post(conn, Routes.gifter_path(conn, :create), gifter: attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.gifter_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "foo@example.com",
               "name" => "foo bar",
               "phone_number" => "0123456789"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.gifter_path(conn, :create), gifter: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update gifter" do
    setup [:create_gifter]

    test "renders gifter when data is valid", %{conn: conn, gifter: %Gifter{id: id} = gifter} do
      conn = put(conn, Routes.gifter_path(conn, :update, gifter), gifter: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.gifter_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "bar@example.com",
               "name" => "bar baz",
               "phone_number" => "0987654321"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, gifter: gifter} do
      conn = put(conn, Routes.gifter_path(conn, :update, gifter), gifter: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete gifter" do
    setup [:create_gifter]

    test "deletes chosen gifter", %{conn: conn, gifter: gifter} do
      conn = delete(conn, Routes.gifter_path(conn, :delete, gifter))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.gifter_path(conn, :show, gifter))
      end
    end
  end

  defp create_gifter(_) do
    gifter = fixture(:gifter)
    {:ok, gifter: gifter}
  end
end

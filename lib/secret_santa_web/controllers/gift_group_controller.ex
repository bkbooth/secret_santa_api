defmodule SecretSantaWeb.GiftGroupController do
  use SecretSantaWeb, :controller

  alias SecretSanta.Gifts
  alias SecretSanta.Gifts.GiftGroup

  action_fallback SecretSantaWeb.FallbackController

  def index(conn, _params) do
    gift_groups = Gifts.list_gift_groups()
    render(conn, "index.json", gift_groups: gift_groups)
  end

  def create(conn, %{"gift_group" => gift_group_params}) do
    with {:ok, %GiftGroup{} = gift_group} <- Gifts.create_gift_group(gift_group_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.gift_group_path(conn, :show, gift_group))
      |> render("show.json", gift_group: gift_group)
    end
  end

  def show(conn, %{"id" => id}) do
    gift_group = Gifts.get_gift_group!(id)
    render(conn, "show.json", gift_group: gift_group)
  end

  def update(conn, %{"id" => id, "gift_group" => gift_group_params}) do
    gift_group = Gifts.get_gift_group!(id)

    with {:ok, %GiftGroup{} = gift_group} <-
           Gifts.update_gift_group(gift_group, gift_group_params) do
      render(conn, "show.json", gift_group: gift_group)
    end
  end

  def delete(conn, %{"id" => id}) do
    gift_group = Gifts.get_gift_group!(id)

    with {:ok, %GiftGroup{}} <- Gifts.delete_gift_group(gift_group) do
      send_resp(conn, :no_content, "")
    end
  end
end

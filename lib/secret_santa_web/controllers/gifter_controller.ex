defmodule SecretSantaWeb.GifterController do
  use SecretSantaWeb, :controller

  alias SecretSanta.Gifts
  alias SecretSanta.Gifts.Gifter

  action_fallback SecretSantaWeb.FallbackController

  def index(conn, _params) do
    gifters = Gifts.list_gifters()
    render(conn, "index.json", gifters: gifters)
  end

  def create(conn, %{"gifter" => gifter_params}) do
    with {:ok, %Gifter{} = gifter} <- Gifts.create_gifter(gifter_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.gifter_path(conn, :show, gifter))
      |> render("show.json", gifter: gifter)
    end
  end

  def show(conn, %{"id" => id}) do
    gifter = Gifts.get_gifter!(id)
    render(conn, "show.json", gifter: gifter)
  end

  def update(conn, %{"id" => id, "gifter" => gifter_params}) do
    gifter = Gifts.get_gifter!(id)

    with {:ok, %Gifter{} = gifter} <- Gifts.update_gifter(gifter, gifter_params) do
      render(conn, "show.json", gifter: gifter)
    end
  end

  def delete(conn, %{"id" => id}) do
    gifter = Gifts.get_gifter!(id)

    with {:ok, %Gifter{}} <- Gifts.delete_gifter(gifter) do
      send_resp(conn, :no_content, "")
    end
  end
end

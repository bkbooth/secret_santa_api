defmodule SecretSantaWeb.GifterView do
  use SecretSantaWeb, :view
  alias SecretSantaWeb.GifterView

  def render("index.json", %{gifters: gifters}) do
    %{data: render_many(gifters, GifterView, "gifter.json")}
  end

  def render("show.json", %{gifter: gifter}) do
    %{data: render_one(gifter, GifterView, "gifter.json")}
  end

  def render("gifter.json", %{gifter: gifter}) do
    %{id: gifter.id, name: gifter.name, email: gifter.email, phone_number: gifter.phone_number}
  end
end

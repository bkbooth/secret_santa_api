defmodule SecretSantaWeb.Router do
  use SecretSantaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SecretSantaWeb do
    pipe_through :api
  end
end

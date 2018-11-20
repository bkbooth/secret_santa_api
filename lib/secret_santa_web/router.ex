defmodule SecretSantaWeb.Router do
  use SecretSantaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SecretSantaWeb do
    pipe_through :api

    scope "/v1" do
      resources "/users", UserController, except: [:new, :edit]
      resources "/gift_groups", GiftGroupController, except: [:new, :edit]
    end
  end
end

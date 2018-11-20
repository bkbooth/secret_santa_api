defmodule SecretSantaWeb.Router do
  use SecretSantaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    if Mix.env() == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: SecretSantaWeb.Schema,
        json_codec: Phoenix.json_library(),
        interface: :playground
    end

    forward "/", Absinthe.Plug,
      schema: SecretSantaWeb.Schema,
      json_codec: Phoenix.json_library()
  end
end

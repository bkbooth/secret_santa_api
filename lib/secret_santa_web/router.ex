defmodule SecretSantaWeb.Router do
  use SecretSantaWeb, :router

  pipeline :graphql do
    plug :fetch_cookies
    plug :accepts, ["json"]
    plug SecretSantaWeb.Context
  end

  scope "/api" do
    pipe_through :graphql

    if Mix.env() == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: SecretSantaWeb.Schema,
        json_codec: Phoenix.json_library(),
        interface: :playground
    end

    forward "/", Absinthe.Plug,
      schema: SecretSantaWeb.Schema,
      json_codec: Phoenix.json_library(),
      before_send: {SecretSantaWeb.Context, :put_token_before_send}
  end
end

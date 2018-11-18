# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :secret_santa,
  ecto_repos: [SecretSanta.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :secret_santa, SecretSantaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Y8ZQehiUdXRGX4dVrCTPE1fRxF0AwPpggnJqLD3/q/49b8z/keR1HVxIiJy10WGL",
  render_errors: [view: SecretSantaWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: SecretSanta.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

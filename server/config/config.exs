# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :server, ServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fg3gu9mIw08oLvtrOU+19ro3d/mwJoUaNzINAWs9vLpuHmSLT+l5ERr0yINx17NO",
  render_errors: [view: ServerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Server.PubSub,
  live_view: [signing_salt: "iEWfRH+l"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :server, upload_folder: File.cwd!()

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :server, ServerWeb.Endpoint,
  http: [port: 4002],
  server: false

config :server, upload_folder: Path.join(System.tmp_dir!, "server_test")

# Print only warnings and errors during test
config :logger, level: :warn

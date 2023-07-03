# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :todo_api,
  ecto_repos: [TodoApi.Repo],
  generators: [binary_id: true]

config :todo_api, TodoApiWeb.Auth.Guardian,
       issuer: "todo_api",
       secret_key: "cz8yR0bdxJDorpPn5HaSvTGDSUVTynDB2Q1Qk0hCyeI/D87mPnHzE4OEhmrcatPF"

# Configures the endpoint
config :todo_api, TodoApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: TodoApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: TodoApi.PubSub,
  live_view: [signing_salt: "7UCJOHIj"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :todo_api, TodoApi.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

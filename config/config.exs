# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ranking,
  ecto_repos: [Ranking.Repo]

# Configures the endpoint
config :ranking, RankingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "y0x0i1Itf2TtljhnynM8W2/i9WyrySC1sx4dnc9yzUaWkch1ar3EJtRPL4uRVC5d",
  render_errors: [view: RankingWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Ranking.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configures Ueberauth

config :ueberauth, Ueberauth,
  base_path: "/api/auth",
  providers: [
    identity: {Ueberauth.Strategy.Identity, [
      callback_methods: ["POST"],
      callback_path: "/api/auth/identity/callback",
      nickname_field: :username,
      param_nesting: "user",
      uid_field: :username
    ]}
  ]

# Configures Guardian

config :ranking, Ranking.Guardian,
  issuer: "ranking",
  secret_key: "use mix phx.gen.secret",
  permissions: %{
    default: [:read_users, :write_users]
  }

config :ranking, RankingWeb.Plug.AuthAccessPipeline,
  module: Ranking.Guardian,
  error_handler: RankingWeb.Plug.AuthErrorHandler


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

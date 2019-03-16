use Mix.Config

config :elite_investigations, EliteInvestigationsWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "www.elite-investigations.space", port: 80],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE")

config :elite_investigations, EliteInvestigations.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

# Do not print debug messages in production
config :logger, level: :info

# Production scheduled jobs
config :elite_investigations, EliteInvestigations.Scheduler,
  jobs: [
    # Update GalNet database every four hours
    {"0 */4 * * *", {EliteInvestigations.Galnet, :update, []}}
  ]

# Configure error tracking system
config :sentry,
  tags: %{
    env: "production"
  }

use Mix.Config

config :elite_investigations,
  ecto_repos: [EliteInvestigations.Repo]

config :elite_investigations, EliteInvestigationsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cQ3Va4vQJrHIdSOc9bmZ16VNTbPu+T/QSKxmL+GWrUj00qAR6qgjTFAkJFTRIuex",
  render_errors: [view: EliteInvestigationsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: EliteInvestigations.PubSub, adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Phoenix Generators
config :phoenix, :generators, binary_id: true

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

config :sentry,
  dsn: "https://db898e07372d4f2e91043a897a179476@sentry.io/1417045",
  included_environments: [:prod],
  environment_name: Mix.env(),
  enable_source_code_context: true,
  root_source_code_path: File.cwd!()

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

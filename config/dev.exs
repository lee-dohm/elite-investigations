use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :elite_investigations, EliteInvestigationsWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# Watch static and templates for browser reloading.
config :elite_investigations, EliteInvestigationsWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/elite_investigations_web/views/.*(ex)$},
      ~r{lib/elite_investigations_web/templates/.*(eex)$}
    ]
  ]

config :elite_investigations, EliteInvestigations.Repo,
  username: "postgres",
  password: "postgres",
  database: "elite_investigations_dev",
  hostname: "localhost",
  pool_size: 10

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :ex_doc, :markdown_processor, ExDoc.Markdown.Cmark

config :elite_investigations, EliteInvestigations.Scheduler,
  jobs: [
    # Update GalNet database every hour
    {"@hourly", {EliteInvestigations.Galnet, :update, []}}
  ]

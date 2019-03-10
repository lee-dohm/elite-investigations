defmodule EliteInvestigations.MixProject do
  use Mix.Project

  def project do
    [
      app: :elite_investigations,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      docs: docs()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {EliteInvestigations.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:cmark, "~> 0.7"},
      {:ecto_sql, "~> 3.0"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_octicons, "~> 0.3.0"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_slime, "~> 0.12.0"},
      {:phoenix, "~> 1.4.1"},
      {:plug_cowboy, "~> 2.0"},
      {:postgrex, ">= 0.0.0"},
      {:quantum, "~> 2.3"},
      {:timex, "~> 3.0"},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.19", only: [:dev, :test], runtime: false},
      {:phoenix_live_reload, "~> 1.2", only: :dev}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "CODE_OF_CONDUCT.md",
        "CONTRIBUTING.md",
        "README.md": [
          filename: "readme",
          title: "README"
        ],
        "LICENSE.md": [
          filename: "license",
          title: "License"
        ]
      ],
      groups_for_modules: [
        Controllers: [
          ~r{^EliteInvestigations.*Controller$}
        ],
        "Ecto Types": [
          ~r{^EliteInvestigations.Ecto.*}
        ],
        Helpers: [
          ~r{^EliteInvestigations.*Helpers$}
        ],
        Localization: [
          EliteInvestigationsWeb.Gettext
        ],
        Sockets: [
          ~r{^EliteInvestigationsWeb.*Socket$}
        ],
        Test: [
          ~r{^EliteInvestigations.*(Channel|Conn|Data)Case$},
          ~r{^EliteInvestigations.Support},
          ~r{^Support}
        ],
        Views: [
          ~r{^EliteInvestigationsWeb.*View$}
        ]
      ]
    ]
  end
end

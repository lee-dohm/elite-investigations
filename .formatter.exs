[
  import_deps: [:ecto, :phoenix],
  inputs: [
    "*.{ex,exs}",
    "priv/*/seeds.exs",
    "priv/repo/update_galnet.exs",
    "{config,lib,test}/**/*.{ex,exs}"
  ],
  subdirectories: ["priv/*/migrations"]
]

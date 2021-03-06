# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EliteInvestigations.Repo.insert!(%EliteInvestigations.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias EliteInvestigations.Galnet

__DIR__
|> Path.join("galnet-sample.json")
|> File.read!()
|> Galnet.load_feed()

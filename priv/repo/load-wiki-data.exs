alias EliteInvestigations.Galnet

__DIR__
|> Path.join("frank-heinrich-data.json")
|> File.read!()
|> Galnet.load_feed()

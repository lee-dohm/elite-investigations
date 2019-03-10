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

alias EliteInvestigations.Elite

__DIR__
|> Path.join("galnet-sample.json")
|> File.read!()
|> Jason.decode!(keys: :atoms)
|> Enum.map(fn story ->
     Map.update!(story, :date, fn text ->
       ~r{(\d+)\s+([A-Z]+)\s+(\d+)}
       |> Regex.replace(text, fn _, day, month, year ->
            month = String.slice(month, 0, 1) <> String.downcase(String.slice(month, 1, 2))

            "#{day} #{month} #{year}"
          end)
       |> Timex.parse!("%d %b %Y", :strftime)
     end)
   end)
|> Enum.each(fn story -> Elite.create_story(story) end)

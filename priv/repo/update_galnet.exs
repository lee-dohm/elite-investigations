Application.ensure_all_started(:inets)
Application.ensure_all_started(:ssl)

alias EliteInvestigations.Elite

feed =
  'https://elitedangerous-website-backend-production.elitedangerous.com/api/galnet?_format=json'

{:ok, resp} = :httpc.request(:get, {feed, []}, [], [body_format: :binary])
{{_, 200, 'OK'}, _headers, body} = resp

body
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
|> Enum.each(fn story ->
     unless Elite.story_exists?(story.nid), do: Elite.create_story(story)
   end)

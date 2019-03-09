Application.ensure_all_started(:inets)
Application.ensure_all_started(:ssl)

alias EliteInvestigations.Elite

feed =
  'https://elitedangerous-website-backend-production.elitedangerous.com/api/galnet?_format=json'

{:ok, resp} = :httpc.request(:get, {feed, []}, [], [body_format: :binary])
{{_, 200, 'OK'}, _headers, body} = resp

body
|> Jason.decode!(keys: :atoms)
|> Enum.each(fn story ->
     unless Elite.story_exists?(story.nid), do: Elite.create_story(story)
   end)

defmodule EliteInvestigations.Galnet do
  @moduledoc """
  Functions for dealing with GalNet.
  """

  alias EliteInvestigations.Elite

  require Logger

  @doc """
  Adds new GalNet stories to the database.
  """
  def update do
    feed =
      'https://elitedangerous-website-backend-production.elitedangerous.com/api/galnet?_format=json'

    Logger.debug("Download feed: #{feed}")

    {:ok, resp} = :httpc.request(:get, {feed, []}, [], body_format: :binary)
    {{_, 200, 'OK'}, _headers, body} = resp

    Logger.debug("Update GalNet records")

    body
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(fn story ->
         unless Elite.story_exists?(story.nid), do: Elite.create_story(story)
       end)
  end
end

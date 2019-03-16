defmodule EliteInvestigations.Galnet do
  @moduledoc """
  Functions for downloading the GalNet feed and loading it into the database.
  """

  alias EliteInvestigations.Elite
  alias EliteInvestigations.Elite.Story
  alias EliteInvestigations.Maintenance

  require Logger

  @doc """
  Loads the JSON feed data into the database.
  """
  def load_feed(body) do
    Logger.debug("Update GalNet records")

    body
    |> Jason.decode!(keys: :atoms)
    |> Enum.map(&clean_feed_data/1)
    |> Enum.each(fn story ->
      unless Elite.story_exists?(story.nid), do: Elite.create_story(story)
    end)

    Logger.debug("Set last updated record")
    Maintenance.set_last_updated!(Story)
  end

  @doc """
  Adds new GalNet stories from the Frontier Developments feed to the database.
  """
  def update do
    feed =
      'https://elitedangerous-website-backend-production.elitedangerous.com/api/galnet?_format=json'

    Logger.debug(fn -> "Download feed: #{feed}" end)

    {:ok, resp} = :httpc.request(:get, {feed, []}, [], body_format: :binary)
    {{_, 200, 'OK'}, _headers, body} = resp

    load_feed(body)
  end

  defp clean_feed_data(story) do
    story
    |> Map.update!(:body, &String.trim/1)
    |> Map.update!(:image, &String.trim/1)
    |> Map.update!(:slug, &String.trim/1)
    |> Map.update!(:title, &String.trim/1)
  end
end

defmodule EliteInvestigations.Galnet do
  @moduledoc """
  Functions for dealing with GalNet data.
  """

  alias EliteInvestigations.Elite

  require Logger

  @doc """
  Converts the body text from the Frontier Development format to a more HTML-standard format.

  It does this by:

  1. Removing `br` tags
  1. Wrapping normal paragraphs in `p` tags
  1. Wrapping paragraphs that consist solely of a quotation in `blockquote` tags
  """
  def normalize_body(body) do
    strip_p_tags = ~r{\A<p>(.+)</p>\z}ms
    body = String.trim(body)

    strip_p_tags
    |> Regex.run(body)
    |> List.last()
    |> String.split(~r{<br\s*/>})
    |> Enum.map(&String.trim/1)
    |> Enum.map(&wrap_in_tags/1)
    |> Enum.join("\n")
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

    Logger.debug("Update GalNet records")

    body
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(fn story ->
      unless Elite.story_exists?(story.nid), do: Elite.create_story(story)
    end)
  end

  defp wrap_in_tags(para) do
    if Regex.match?(~r{\A["“](.+)["”]\z}u, para) do
      Regex.replace(~r{\A["“](.+)["”]\z}u, para, "<blockquote>\\0</blockquote>")
    else
      "<p>#{para}</p>"
    end
  end
end

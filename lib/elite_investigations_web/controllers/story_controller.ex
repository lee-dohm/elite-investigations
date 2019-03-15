defmodule EliteInvestigationsWeb.StoryController do
  @moduledoc """
  Handles requests for GalNet story routes.
  """

  use EliteInvestigationsWeb, :controller

  alias EliteInvestigations.Elite

  @doc """
  Displays the list of GalNet stories.
  """
  def index(conn, _params) do
    stories = Elite.list_stories()

    render(conn, "index.html", search_text: "", stories: stories)
  end

  @doc """
  Displays the search results for `search_text`.
  """
  def search(conn, %{"q" => search_text}) do
    if search_text == "", do: redirect(conn, to: Routes.story_path(conn, :index))

    stories = Elite.search_stories(search_text)

    render(conn, "index.html", search_text: search_text, stories: stories)
  end

  @doc """
  Displays the GalNet story identified by `nid`.
  """
  def show(conn, %{"id" => nid}) do
    story = Elite.get_story_by_nid!(nid)

    render(conn, "show.html", story: story)
  end
end

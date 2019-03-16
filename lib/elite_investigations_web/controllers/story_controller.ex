defmodule EliteInvestigationsWeb.StoryController do
  @moduledoc """
  Handles requests for GalNet story routes.
  """

  use EliteInvestigationsWeb, :controller

  alias EliteInvestigations.Elite
  alias EliteInvestigations.Elite.Story
  alias EliteInvestigations.Maintenance

  @doc """
  Displays the list of GalNet stories.
  """
  def index(conn, _params) do
    stories = Elite.list_stories()
    last_updated = Maintenance.get_last_updated!(Story)

    render(conn, "index.html", last_updated: last_updated, search_text: "", stories: stories)
  end

  @doc """
  Displays the search results for `search_text`.
  """
  def search(conn, %{"q" => ""}), do: redirect(conn, to: Routes.story_path(conn, :index))

  def search(conn, %{"q" => search_text}) do
    stories = Elite.search_stories(search_text)
    last_updated = Maintenance.get_last_updated!(Story)

    render(conn, "index.html", last_updated: last_updated, search_text: search_text, stories: stories)
  end

  @doc """
  Displays the GalNet story identified by `nid`.
  """
  def show(conn, %{"id" => nid}) do
    story = Elite.get_story_by_nid!(nid)

    render(conn, "show.html", story: story)
  end
end

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

    render(conn, "index.html", stories: stories)
  end

  def show(conn, %{"id" => nid}) do
    story = Elite.get_story_by_nid!(nid)

    render(conn, "show.html", story: story)
  end
end

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
end

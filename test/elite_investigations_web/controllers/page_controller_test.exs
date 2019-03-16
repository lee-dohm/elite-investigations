defmodule EliteInvestigationsWeb.PageControllerTest do
  use EliteInvestigationsWeb.ConnCase

  describe "GET /" do
    setup %{conn: conn} do
      conn = get(conn, "/")
      body = html_response(conn, 200)

      {:ok, body: body, conn: conn}
    end

    test "masthead logo link exists", %{body: body} do
      masthead_logo = Floki.find(body, "a.masthead-logo")

      assert Floki.attribute(masthead_logo, "href") == ["/"]
      assert Floki.text(masthead_logo) == "Elite: Investigations"
    end

    test "subreddit link exists", %{body: body} do
      subreddit_link = Floki.find(body, "nav.masthead-nav a")

      assert Floki.attribute(subreddit_link, "href") == [
               "https://www.reddit.com/r/EliteInvestigations"
             ]

      assert Floki.text(subreddit_link) == "Subreddit"
    end
  end
end

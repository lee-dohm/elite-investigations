defmodule EliteInvestigationsWeb.PageControllerTest do
  use EliteInvestigationsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Elite: Investigations"
  end
end

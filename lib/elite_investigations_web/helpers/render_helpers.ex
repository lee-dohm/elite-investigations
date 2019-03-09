defmodule EliteInvestigationsWeb.RenderHelpers do
  @moduledoc """
  Helper functions for rendering templates in views.
  """

  use Phoenix.HTML

  import Phoenix.View

  def render_many_or_blank(enumerable, many_template, blank_template, assigns = %{conn: conn}) do
    render_many_or_blank(
      enumerable,
      conn.private.phoenix_view,
      many_template,
      blank_template,
      assigns
    )
  end

  def render_many_or_blank(enumerable, view, many_template, blank_template, assigns) do
    if Enum.empty?(enumerable) do
      render(view, blank_template, assigns)
    else
      render_many(enumerable, view, many_template, assigns)
    end
  end
end

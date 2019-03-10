defmodule EliteInvestigationsWeb.RenderHelpers do
  @moduledoc """
  Helper functions for rendering templates in views.
  """

  use Phoenix.HTML

  import Phoenix.View

  alias EliteInvestigations.Elite.Story

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

  def render_story_body(story = %Story{}) do
    story_body =
      ~r{\<br\s*/\>}
      |> Regex.split(story.body, trim: true)
      |> Enum.map(fn paragraph -> "<p>#{paragraph}</p>" end)
      |> Enum.join()

    raw(story_body)
  end
end

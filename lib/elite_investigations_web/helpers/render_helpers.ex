defmodule EliteInvestigationsWeb.RenderHelpers do
  @moduledoc """
  Helper functions for rendering templates in views.
  """

  use Phoenix.HTML

  import Phoenix.View

  alias EliteInvestigations.Elite.Story

  @doc """
  Renders `enumerable` using one of the templates depending on whether it is empty.

  This is specifically useful in combination with Primer's
  [blankslate](https://primer.style/css/components/blankslate) element.
  """
  def render_many_or_blank(enumerable, many_template, blank_template, assigns = %{conn: conn}) do
    render_many_or_blank(
      enumerable,
      conn.private.phoenix_view,
      many_template,
      blank_template,
      assigns
    )
  end

  @doc """
  Renders `enumerable` using one of the templates for `view` depending on whether it is empty.

  This is specifically useful in combination with Primer's
  [blankslate](https://primer.style/css/components/blankslate) element.
  """
  def render_many_or_blank(enumerable, view, many_template, blank_template, assigns) do
    if Enum.empty?(enumerable) do
      render(view, blank_template, assigns)
    else
      render_many(enumerable, view, many_template, assigns)
    end
  end

  @doc """
  Renders the body text of a `Story`.
  """
  def render_story_body(story = %Story{}) do
    story_body =
      ~r{\<br\s*/\>}
      |> Regex.split(story.body, trim: true)
      |> Enum.map(fn paragraph -> "<p>#{paragraph}</p>" end)
      |> Enum.join()

    raw(story_body)
  end
end

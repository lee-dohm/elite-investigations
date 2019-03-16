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
    story.body
    |> normalize_body()
    |> raw()
  end

  # Converts the body text from the Frontier Development format to a more HTML-standard format.
  #
  # It does this by:
  #
  # 1. Removing `br` tags
  # 2. Wrapping normal paragraphs in `p` tags
  # 3. Wrapping paragraphs that consist solely of a quotation in `blockquote` tags
  defp normalize_body(body) do
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

  defp wrap_in_tags(para) do
    if Regex.match?(~r{\A["“](.+)["”]\z}u, para) do
      Regex.replace(~r{\A["“](.+)["”]\z}u, para, "<blockquote>\\0</blockquote>")
    else
      "<p>#{para}</p>"
    end
  end
end

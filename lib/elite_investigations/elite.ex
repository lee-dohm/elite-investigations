defmodule EliteInvestigations.Elite do
  @moduledoc """
  Context for dealing with actual Elite: Dangerous data.
  """

  import Ecto.Query, warn: false

  alias EliteInvestigations.Elite.Story
  alias EliteInvestigations.Repo

  @doc """
  Returns the list of stories.

  ## Options

  * `:order_by` How to sort the stories -- defaults to by `date` then `nid` from newest

  ## Examples

  ```
  iex> list_stories()
  [%Story{}, ...]
  ```
  """
  def list_stories(opts \\ []) do
    order = Keyword.get(opts, :order_by, desc: :date, desc: :nid)

    Repo.all(from s in Story, order_by: ^order)
  end

  @doc """
  Gets a single story.

  Raises `Ecto.NoResultsError` if the story does not exist.

  ## Examples

  ```
  iex> get_story!(123)
  %Story{}

  iex> get_story!(456)
  ** (Ecto.NoResultsError)
  ```
  """
  def get_story!(id), do: Repo.get!(Story, id)

  @doc """
  Gets a single story by Galnet ID.

  Raises `Ecto.NoResultsError` if the story does not exist.

  ## Examples

  ```
  iex> get_story!(123)
  %Story{}

  iex> get_story!(456)
  ** (Ecto.NoResultsError)
  ```
  """
  def get_story_by_nid!(nid), do: Repo.get_by!(Story, nid: nid)

  @doc """
  Indicates whether the story with the given Galnet ID exists.
  """
  def story_exists?(nid), do: !is_nil(Repo.get_by(Story, nid: nid))

  @doc """
  Creates a story.

  ## Examples

  ```
  iex> create_story(%{field: value})
  {:ok, %Story{}}

  iex> create_story(%{field: bad_value})
  {:error, %Ecto.Changeset{}}
  ```
  """
  def create_story(attrs \\ %{}) do
    %Story{}
    |> Story.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a story.

  ## Examples

  ```
  iex> update_story(story, %{field: new_value})
  {:ok, %Story{}}

  iex> update_story(story, %{field: bad_value})
  {:error, %Ecto.Changeset{}}
  ```
  """
  def update_story(story = %Story{}, attrs) do
    story
    |> Story.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a story.

  ## Examples

  ```
  iex> delete_story(story)
  {:ok, %Story{}}

  iex> delete_story(story)
  {:error, %Ecto.Changeset{}}
  ```
  """
  def delete_story(story = %Story{}) do
    Repo.delete(story)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking story changes.

  ## Examples

  ```
  iex> change_story(story)
  %Ecto.Changeset{source: %Story{}}
  ```
  """
  def change_story(story = %Story{}) do
    Story.changeset(story, %{})
  end

  @doc """
  Searches stories for `search_text`.

  Matches are ranked by weighting title matches heavier than body matches.

  Returns a list of story network IDs and titles.
  """
  def search_stories(search_text) do
    sub_query =
      from s in Story,
      select: %{
        s_nid: s.nid,
        s_title: s.title,
        document: fragment(
                    "setweight(to_tsvector(?), 'A') || setweight(to_tsvector(?), 'B')",
                    s.title,
                    s.body
                  )
      }

    query =
      from s in Story,
      join: q in subquery(sub_query),
      on: q.s_nid == s.nid,
      where: fragment("? @@ websearch_to_tsquery(?)", q.document, ^search_text),
      order_by: fragment("ts_rank(?, websearch_to_tsquery(?)) DESC", q.document, ^search_text)

    Repo.all(query)
  end
end

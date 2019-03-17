defmodule EliteInvestigations.Elite.Story do
  @moduledoc """
  Database schema for GalNet news stories.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias EliteInvestigations.Ecto.GalnetDate

  @derive {Phoenix.Param, key: :nid}

  schema "stories" do
    field :body, :string
    field :date, GalnetDate
    field :from_frontier, :boolean
    field :image, :string
    field :nid, :integer
    field :slug, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:title, :body, :nid, :date, :from_frontier, :image, :slug])
    |> validate_required([:title, :body, :nid, :date, :from_frontier, :image, :slug])
  end
end

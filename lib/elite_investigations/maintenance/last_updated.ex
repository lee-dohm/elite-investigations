defmodule EliteInvestigations.Maintenance.LastUpdated do
  @moduledoc """
  Represents a last updated record.
  """
  use Ecto.Schema

  import Ecto.Changeset

  schema "last_updated" do
    field :name, :string
    field :updated_at, :utc_datetime
  end

  @doc false
  def changeset(last_updated, attrs) do
    last_updated
    |> cast(attrs, [:name, :updated_at])
    |> validate_required([:name, :updated_at])
  end
end

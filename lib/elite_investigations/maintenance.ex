defmodule EliteInvestigations.Maintenance do
  @moduledoc """
  Functions for tracking maintenance tasks.
  """

  import Ecto.Query, warn: false

  alias EliteInvestigations.Repo
  alias EliteInvestigations.Maintenance.LastUpdated

  @doc """
  Returns the list of last updated records.

  ## Examples

  ```
  iex> list_last_updated()
  [%LastUpdated{}, ...]
  ```
  """
  def list_last_updated do
    Repo.all(LastUpdated)
  end

  @doc """
  Gets a single last updated record.

  Raises `Ecto.NoResultsError` if the Last updated does not exist.

  ## Examples

  ```
  iex> get_last_updated!("Service name")
  %LastUpdated{}

  iex> get_last_updated!("Bad service name")
  ** (Ecto.NoResultsError)
  ```
  """
  def get_last_updated!(name) when is_binary(name), do: Repo.get_by!(LastUpdated, name: name)

  def get_last_updated!(record_type) when is_atom(record_type) do
    record_type
    |> Atom.to_string()
    |> get_last_updated!()
  end

  @doc """
  Sets the last updated time of a given service to now.

  ## Examples

  ```
  iex> set_last_updated!("Service name")
  %LastUpdated{}
  ```
  """
  def set_last_updated!(record_type) when is_atom(record_type) do
    record_type
    |> Atom.to_string()
    |> set_last_updated!()
  end

  def set_last_updated!(service_name) when is_binary(service_name) do
    record =
      case Repo.get_by(LastUpdated, name: service_name) do
        nil -> %LastUpdated{}
        last_updated -> last_updated
      end

    record
    |> LastUpdated.changeset(%{name: service_name, updated_at: Timex.now()})
    |> Repo.insert_or_update!()
  end
end

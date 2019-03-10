defmodule EliteInvestigations.Ecto.GalnetDate do
  @moduledoc """
  An `Ecto.Type` that handles the conversion between a `utc_datetime` in the database and a
  `String` in memory.

  In the documentation below, these will be referred to as the "database type" and the "memory
  type".
  """

  @behaviour Ecto.Type

  @doc """
  Returns the database type.

  See: `c:Ecto.Type.type/0`
  """
  @impl Ecto.Type
  def type, do: :utc_datetime

  @doc """
  Converts the given input to the memory type.

  See: `c:Ecto.Type.cast/1`
  """
  @impl Ecto.Type
  def cast(binary) when is_binary(binary), do: {:ok, binary}
  def cast(date = %DateTime{}), do: {:ok, date_to_binary(date)}
  def cast(date = %NaiveDateTime{}), do: {:ok, date_to_binary(date)}
  def cast(_other), do: :error

  @doc """
  Converts the database type to the memory type.

  See: `c:Ecto.Type.load/1`
  """
  @impl Ecto.Type
  def load(date = %DateTime{}), do: {:ok, date_to_binary(date)}
  def load(date = %NaiveDateTime{}), do: {:ok, date_to_binary(date)}
  def load(_other), do: :error

  @doc """
  Converts the memory type to the database type.

  See: `c:Ecto.Type.dump/1`
  """
  @impl Ecto.Type
  def dump(binary) when is_binary(binary), do: {:ok, binary_to_date(binary)}
  def dump(_other), do: :error

  defp binary_to_date(binary) do
    ~r{(\d+)\s+([A-Z]+)\s+(\d+)}
    |> Regex.replace(binary, fn _, day, month, year ->
      month = String.slice(month, 0, 1) <> String.downcase(String.slice(month, 1, 2))

      "#{day} #{month} #{year}"
    end)
    |> Timex.parse!("%d %b %Y", :strftime)
  end

  defp date_to_binary(date) do
    date
    |> Timex.format!("%d %b %Y", :strftime)
    |> String.upcase()
  end
end

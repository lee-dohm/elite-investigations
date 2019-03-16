defmodule EliteInvestigations.MaintenanceTest do
  use EliteInvestigations.DataCase

  alias EliteInvestigations.Maintenance

  describe "last_updated" do
    alias EliteInvestigations.Maintenance.LastUpdated

    @valid_name "some name"
    @invalid_name nil

    def last_updated_fixture(name), do: Maintenance.set_last_updated!(name)

    def last_updated_fixture(name, time) do
      %LastUpdated{}
      |> LastUpdated.changeset(%{name: name, updated_at: time})
      |> Repo.insert!()
    end

    test "list_last_updated/0 returns all last updated records" do
      last_updated = last_updated_fixture(@valid_name)

      assert Maintenance.list_last_updated() == [last_updated]
    end

    test "get_last_updated!/1 returns the last updated record with given name" do
      last_updated = last_updated_fixture(@valid_name)

      assert Maintenance.get_last_updated!(@valid_name) == last_updated
    end

    test "get_last_updated!/1 raises an error when no record exists" do
      assert_raise Ecto.NoResultsError, fn -> Maintenance.get_last_updated!(@valid_name) end
    end

    test "set_last_updated!/1 creates a new record if one doesn't exist" do
      assert_raise Ecto.NoResultsError, fn -> Maintenance.get_last_updated!(@valid_name) end

      last_updated = Maintenance.set_last_updated!(@valid_name)

      assert Maintenance.get_last_updated!(@valid_name) == last_updated
    end

    test "set_last_updated!/1 updates the last updated time when the record exists" do
      last_updated_fixture(@valid_name, ~N[2011-01-23T00:00:00])

      Maintenance.set_last_updated!(@valid_name)

      assert Maintenance.get_last_updated!(@valid_name).updated_at != ~N[2011-01-23T00:00:00]
    end

    test "set_last_updated!/1 raises an error when an invalid name is given" do
      assert_raise Ecto.InvalidChangesetError, fn ->
        Maintenance.set_last_updated!(@invalid_name)
      end
    end
  end
end

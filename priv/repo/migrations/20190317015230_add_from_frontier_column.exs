defmodule EliteInvestigations.Repo.Migrations.AddFromFrontierColumn do
  use Ecto.Migration

  def change do
    alter table(:stories) do
      add :from_frontier, :boolean, null: false, default: true
    end
  end
end

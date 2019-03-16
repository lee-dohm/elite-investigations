defmodule EliteInvestigations.Repo.Migrations.CreateLastUpdated do
  use Ecto.Migration

  def change do
    create table(:last_updated) do
      add :name, :string, null: false
      add :updated_at, :utc_datetime, null: false
    end

    create index(:last_updated, [:name], unique: true)
  end
end

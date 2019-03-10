defmodule EliteInvestigations.Repo.Migrations.CreateStories do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :title, :string, null: false
      add :body, :text, null: false
      add :nid, :integer, null: false
      add :date, :utc_datetime, null: false
      add :image, :string, null: false
      add :slug, :string, null: false

      timestamps()
    end

    create index(:stories, [:date])
    create index(:stories, [:nid], unique: true)
  end
end

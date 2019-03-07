defmodule EliteInvestigations.Repo.Migrations.CreateStories do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :title, :string, null: false
      add :body, :text, null: false
      add :nid, :integer, null: false
      add :date, :string, null: false
      add :image, :string, null: false
      add :slug, :string, null: false

      timestamps()
    end
  end
end

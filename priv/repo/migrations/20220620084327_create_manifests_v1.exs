defmodule OkhValidator.Repo.Migrations.CreateManifestsV1 do
  use Ecto.Migration

  def change do
    create table(:manifests_v1) do
      add :title, :string
      add :version, :string
      add :description, :string
      add :intended_use, :string
      add :health_safety_notice, :string
      add :development_stage, :string
      add :project_link, :string
      add :image, :string
      add :documentation_home, :string
      add :archive_download, :string
      add :bom, :string
      add :tool_list, :string
      add :date_created, :date
      add :date_updated, :date
      add :made, :boolean
      add :made_independently, :boolean
      add :keywords, {:array, :string}

      timestamps()
    end
  end
end

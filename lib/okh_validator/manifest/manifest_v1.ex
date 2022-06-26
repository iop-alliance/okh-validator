defmodule OkhValidator.Manifest.Manifest_v1 do
  use Ecto.Schema
  import Ecto.Changeset

  schema "manifests_v1" do
    field :title, :string
    field :version, :string
    field :description, :string
    field :intended_use, :string
    field :health_safety_notice, :string
    field :development_stage, :string
    field :project_link, :string
    field :image, :string
    field :documentation_home, :string
    field :archive_download, :string
    field :bom, :string
    field :tool_list, :string

    field :date_created, :date
    field :date_updated, :date

    field :made, :boolean
    field :made_independently, :boolean

    field :keywords, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(manifest_v1, attrs) do
    manifest_v1
    |> cast(attrs, [
      :title,
      :version,
      :description,
      :intended_use,
      :health_safety_notice,
      :development_stage,
      :project_link,
      :image,
      :documentation_home,
      :archive_download,
      :bom,
      :tool_list,
      :date_created,
      :date_updated,
      :made,
      :made_independently,
      :keywords,
    ])
    |> validate_required([:title, :description])
  end
end

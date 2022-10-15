defmodule Validators.ManifestAuthorValidator do
  alias V1ValidationHelpers

  def validate_manifest_author(validations, fields) do
    case Map.get(fields, "manifest-author") do
      nil ->
        Map.merge(validations, %{"manifest-author" => %{status: "not found"}})
      _ ->
        %{"manifest-author" => field} = fields

        manifest_author_validations =
          %{}
          |> validate_manifest_author_name(field)
          |> validate_manifest_author_affiliation(field)
          |> validate_manifest_author_email(field)
          |> validate_name_found()

        Map.merge(validations, %{"manifest-author" => %{status: "ok", validations: manifest_author_validations}})
    end
  end

  defp validate_manifest_author_name(manifest_author_validations, manifest_author) do
    case Map.get(manifest_author, "name") do
      nil ->
        Map.merge(manifest_author_validations, %{name: %{status: "not found"}})
      _ ->
        %{"name" => name} = manifest_author
        Map.merge(manifest_author_validations, %{name: %{status: "ok", value: name}})
    end
  end

  defp validate_manifest_author_affiliation(manifest_author_validations, manifest_author) do
    case Map.get(manifest_author, "affiliation") do
      nil ->
        Map.merge(manifest_author_validations, %{affiliation: %{status: "not found"}})
      _ ->
        %{"affiliation" => affiliation} = manifest_author
        Map.merge(manifest_author_validations, %{affiliation: %{status: "ok", value: affiliation}})
    end
  end

  defp validate_manifest_author_email(manifest_author_validations, manifest_author) do
    case Map.get(manifest_author, "affiliation") do
      nil ->
        Map.merge(manifest_author_validations, %{email: %{status: "not found"}})
      _ ->
        %{"email" => email} = manifest_author
        Map.merge(manifest_author_validations, %{email: V1ValidationHelpers.validate_email(email)})
    end
  end

  defp validate_name_found(manifest_author_validations) do
    %{name: %{status: status}} = manifest_author_validations
    case status do
      "ok" ->
        %{status: "ok", validations: manifest_author_validations}
      "not found" ->
        %{status: "error", message: "author name is required", validations: manifest_author_validations}
    end
  end
end

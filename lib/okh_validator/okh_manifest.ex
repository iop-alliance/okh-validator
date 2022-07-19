defmodule OkhValidator.OkhManifest do
  alias Validators.{
    ArrayValidator,
    BooleanValidator,
    ContactValidator,
    ContributorsValidator,
    DateValidator,
    ManifestAuthorValidator,
    LanguageValidator,
    LicenseValidator,
    LinkListValidator,
    PersonValidator,
    TextValidator,
    TranslationValidator,
    UrlValidator
  }

  @date_fields ["date-created", "date-updated"]
  @text_fields [
    "title",
    "description",
    "intended-use",
    "version",
    "health-safety-notice",
    "development-stage",
    "derivative-of", # TODO: use project validator (https://standards.internetofproduction.org/pub/okh#derivative-of)
    "variant-of", # TODO: use project validator (https://standards.internetofproduction.org/pub/okh#derivative-of)
    "sub"] # TODO: use project validator (https://standards.internetofproduction.org/pub/okh#derivative-of)
  @array_fields [
    "keywords",
    "standards-used"] # TODO: create standards validator
  @url_fields [
    "project-link",
    "image",
    "documentation-home",
    "archive-download",
    "bom",
    "tool-list"]
  @boolean_fields [
    "made",
    "made-independently"]
  @link_list_fields [ # TODO: implement link list validator
    "design-files",
    "schematics",
    "making-instructions",
    "manufacturing-files",
    "risk-assessment",
    "tool-settings"  ,
    "quality-instructions",
    "operating-instructions",
    "maintenance-instructions",
    "disposal-instructions",
    "software"]
  @language_fields [ # TODO: implement language validator
    "manifest_language",
    "documentation_language",
    "documentation_language"]
  @translation_fields [ # TODO: implement language validator
    "manifest-is-translation",
    "documentation-is-translation"]

  def validate_manifest(manifest_fields) do
    field_validations =
      %{}
      |> DateValidator.validate_date(manifest_fields, @date_fields)
      |> ManifestAuthorValidator.validate_manifest_author(manifest_fields)
      |> TextValidator.validate_text(manifest_fields, @text_fields)
      |> LicenseValidator.validate_license(manifest_fields)
      |> ArrayValidator.validate_array_field(manifest_fields, @array_fields)
      |> UrlValidator.validate_url(manifest_fields, @url_fields)
      |> ContactValidator.validate_contact(manifest_fields)
      |> ContributorsValidator.validate_contributors(manifest_fields)
      |> BooleanValidator.validate_boolean(manifest_fields, @boolean_fields)
      |> PersonValidator.validate_person_field(manifest_fields, "licensor") # TODO: use license validator (https://standards.internetofproduction.org/pub/okh#license)
      |> LinkListValidator.validate_link_list(manifest_fields, @link_list_fields)
      |> LanguageValidator.validate_language(manifest_fields, @language_fields)
      |> TranslationValidator.validate_translation_field(manifest_fields, @translation_fields)

    manifest_validation = validate_required_fields(field_validations)

    %{
      field_validations: field_validations,
      manifest_validation: manifest_validation
    }
  end

  defp validate_required_fields(field_validations) do
    %{"status" => "ok"}
    |> validate_field_present(field_validations, "title")
    |> validate_field_present(field_validations, "description")
    |> validate_field_present(field_validations, "license")
    |> validate_project_link_or_documentation_home_present(field_validations)
  end

  defp validate_field_present(manifest_validation, field_validations, field) do
    %{^field => %{status: status}} = field_validations
    case status do
      "ok" ->
        Map.merge(manifest_validation, %{field => %{status: "ok"}})
      "not found" ->
        Map.merge(manifest_validation, %{"status" => "error", field => %{status: "error", message: "manifest must have #{field}"}})
      "error" ->
        Map.merge(manifest_validation, %{"status" => "error", field => %{status: "error", message: field_validations[field]["status"]}})
    end
  end

  defp validate_project_link_or_documentation_home_present(manifest_validation, field_validations) do
    %{"project-link" => %{status: project_link_status}, "documentation-home" => %{status: documentation_home_status}} = field_validations
    project_link_or_documentation_home_status = project_link_or_documentation_home_status(project_link_status, documentation_home_status)

    case project_link_or_documentation_home_status["project-link-or-documentation-home"]["status"] do
      "error" ->
        manifest_validation
        |> Map.merge(project_link_or_documentation_home_status)
        |> Map.merge(%{"status" => "error"})
      _ ->
        manifest_validation |> Map.merge(project_link_or_documentation_home_status)
    end
  end

  defp project_link_or_documentation_home_status("ok", _), do: %{"project-link-or-documentation-home" => %{"status" => "ok"}}
  defp project_link_or_documentation_home_status(_, "ok"), do: %{"project-link-or-documentation-home" => %{"status" => "ok"}}
  defp project_link_or_documentation_home_status(_, _) do
    %{"project-link-or-documentation-home" => %{
      "status" =>  "error",
      message: "Neither project-link nor documentation-home are found and valid in the manifest. At least one of them must be present and valid"
    }}
  end
end

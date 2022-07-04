defmodule OkhValidator.OkhManifest do
  alias Validators.{
    ArrayValidator,
    BooleanValidator,
    ContactValidator,
    ContributorsValidator,
    DateValidator,
    ManifestAuthorValidator,
    LanguageValidator,
    LinkListValidator,
    PersonValidator,
    TextValidator,
    TranslationValidator,
    UrlValidator
  }

  def validate_manifest(manifest_fields) do
    field_validations =
      %{}
      |> DateValidator.validate_date(manifest_fields, [
          "date-created", "date-updated"
        ])
      |> ManifestAuthorValidator.validate_manifest_author(manifest_fields)
      |> TextValidator.validate_text(manifest_fields, [
          "title",
          "description",
          "intended-use",
          "version",
          "health-safety-notice",
          "development-stage",
          "derivative-of", # TODO: use project validator (https://standards.internetofproduction.org/pub/okh#derivative-of)
          "variant-of", # TODO: use project validator (https://standards.internetofproduction.org/pub/okh#derivative-of)
          "sub", # TODO: use project validator (https://standards.internetofproduction.org/pub/okh#derivative-of)
          "license" # TODO: use license validator (https://standards.internetofproduction.org/pub/okh#license)
        ])
      |> ArrayValidator.validate_array_field(manifest_fields, [
          "keywords",
          "standards-used" # TODO: create standards validator
        ])
      |> UrlValidator.validate_url(manifest_fields, [
          "project-link",
          "image",
          "documentation-home",
          "archive-download",
          "bom",
          "tool-list"
        ])
      |> ContactValidator.validate_contact(manifest_fields)
      |> ContributorsValidator.validate_contributors(manifest_fields)
      |> BooleanValidator.validate_boolean(manifest_fields, [
          "made",
          "made-independently"
        ])
      |> PersonValidator.validate_person_field(manifest_fields, "licensor") # TODO: use license validator (https://standards.internetofproduction.org/pub/okh#license)
      |> LinkListValidator.validate_link_list(manifest_fields, [ # TODO: implement link list validator
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
          "software"
        ])
      |> LanguageValidator.validate_language(manifest_fields, [ # TODO: implement language validator
          "manifest_language",
          "documentation_language",
          "documentation_language"
        ])
      |> TranslationValidator.validate_translation_field(manifest_fields, [ # TODO: implement language validator
          "manifest-is-translation",
          "documentation-is-translation"
        ])

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

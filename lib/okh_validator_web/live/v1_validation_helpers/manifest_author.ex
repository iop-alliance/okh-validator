defmodule OkhValidatorWeb.V1ValidationHelpers.ManifestAuthor do
  use Phoenix.HTML

  alias OkhValidatorWeb.V1ValidationHelpers.TextField

  def show_validation_result(validatons) do
    show_manifest_author_status(validatons.field_validations["manifest-author"])
  end

  defp show_manifest_author_status(%{status: "ok"} = manifest_author), do: show_manifest_author_validations(manifest_author.validations)
  defp show_manifest_author_status(%{status: status}), do: status

  defp show_manifest_author_validations(%{status: "ok"} = manifest_author_validations) do
    raw(
      "<ul><li>Name: #{TextField.show_validation_result(manifest_author_validations.validations.name)}</li>" <>
      "<li>Email: #{TextField.show_validation_result(manifest_author_validations.validations.email)}</li>" <>
      "<li>Affiliation: #{TextField.show_validation_result(manifest_author_validations.validations.affiliation)}</li></ul>"
    )
  end
  defp show_manifest_author_validations(%{status: "error"} = manifest_author_validations) do
    raw("<span class=\"text-danger\">Error: #{manifest_author_validations.message}</span>")
  end
end

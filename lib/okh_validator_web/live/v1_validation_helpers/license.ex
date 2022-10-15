defmodule OkhValidatorWeb.V1ValidationHelpers.License do
  use Phoenix.HTML

  alias OkhValidatorWeb.V1ValidationHelpers.TextField

  def show_validation_result(validatons) do
    show_status(validatons.field_validations["license"])
  end

  defp show_status(%{status: "ok"} = license), do: check_license_validations(license.validations)
  defp show_status(%{status: status}), do: status

  defp check_license_validations(%{status: "ok"} = license_validations) do
    raw(
      "<ul><li>Documentation: #{TextField.show_validation_result(license_validations.validations.documentation)}</li>" <>
      "<li>Hardware: #{TextField.show_validation_result(license_validations.validations.hardware)}</li>" <>
      "<li>Software: #{TextField.show_validation_result(license_validations.validations.software)}</li></ul>"
    )
  end
  defp check_license_validations(%{status: "error"} = license_validations) do
    raw("<span class=\"text-danger\">Error: #{license_validations.message}</span>")
  end
  defp check_license_validations(license_validations) do
    raw(
      "<p>Something wrong:</p>" <>
      Jason.encode!(license_validations)
    )
  end
end

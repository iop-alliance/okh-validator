defmodule OkhValidatorWeb.V1ValidationHelpers.Contact do
  use Phoenix.HTML

  alias OkhValidatorWeb.V1ValidationHelpers.TextField

  def show_validation_result(validatons) do
    show_contact_status(validatons.field_validations["contact"])
  end

  defp show_contact_status(%{status: "ok"} = contact), do: check_contact_validations(contact)
  defp show_contact_status(%{status: status}), do: status

  defp check_contact_validations(%{status: "ok"} = contact_validations) do
    raw(
      "<ul><li>Name: #{contact_validations.value["name"]}</li>" <>
      "<li>Email: #{contact_validations.value["email"]}</li>" <>
      "<li>Affiliation: #{contact_validations.value["affiliation"]}</li></ul>"
    )
  end
  defp check_contact_validations(%{status: "error"} = contact_validations) do
    raw "<span class=\"text-danger\">Error: " <> contact_validations.message <> "</span>"
  end
end

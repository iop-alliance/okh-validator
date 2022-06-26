defmodule OkhValidatorWeb.ValidationHelpers.Contact do
  use Phoenix.HTML

  alias OkhValidatorWeb.ValidationHelpers.TextField

  def show_validation_result(validatons) do
    show_contact_status(validatons.field_validations[:contact])
  end

  defp show_contact_status(%{status: "ok"} = contact), do: check_contact_validations(contact.validations)
  defp show_contact_status(%{status: status}), do: status

  defp check_contact_validations(%{status: "ok"} = contact_validations) do
    raw(
      "<ul><li>Name: #{TextField.show_validation_result(contact_validations.validations.name)}</li>" <>
      "<li>Email: #{TextField.show_validation_result(contact_validations.validations.email)}</li>" <>
      "<li>Affiliation: #{TextField.show_validation_result(contact_validations.validations.affiliation)}</li></ul>"
    )
  end
  defp check_contact_validations(%{status: "error"} = contact_validations) do
    raw "<span class=\"text-danger\">Error: " <> contact_validations.message <> "</span>"
  end
end

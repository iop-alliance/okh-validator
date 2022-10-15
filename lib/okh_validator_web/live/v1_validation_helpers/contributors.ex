defmodule OkhValidatorWeb.V1ValidationHelpers.Contributors do
  use Phoenix.HTML

  # alias OkhValidatorWeb.V1ValidationHelpers.TextField

  def show_validation_result(validatons) do
    show_status(validatons.field_validations[:contributors])
  end

  defp show_status(%{status: "ok"} = contributors) do
    #check_contact_validations(contact.validations)
    html_escape(Jason.encode!(contributors.value))
  end
  defp show_status(%{status: status}), do: status

end

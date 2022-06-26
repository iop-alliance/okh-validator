defmodule OkhValidatorWeb.ValidationHelpers.License do
  use Phoenix.HTML

  # alias OkhValidatorWeb.ValidationHelpers.TextField

  def show_validation_result(validatons) do
    show_status(validatons.field_validations["license"])
  end

  defp show_status(%{status: "ok"} = license), do: html_escape(Jason.encode!(license.value))
  defp show_status(%{status: status}), do: status

end

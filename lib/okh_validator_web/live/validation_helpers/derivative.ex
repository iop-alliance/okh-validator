defmodule OkhValidatorWeb.ValidationHelpers.Derivative do
  use Phoenix.HTML

  # alias OkhValidatorWeb.ValidationHelpers.TextField

  def show_validation_result(validatons) do
    show_status(validatons.field_validations["derivative-of"])
  end

  defp show_status(%{status: "ok"} = standards), do: html_escape(Jason.encode!(standards.value))
  defp show_status(%{status: status}), do: status

end

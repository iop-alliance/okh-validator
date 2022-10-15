defmodule OkhValidatorWeb.V1ValidationHelpers.Variant do
  use Phoenix.HTML

  # alias OkhValidatorWeb.V1ValidationHelpers.TextField

  def show_validation_result(validatons) do
    show_status(validatons.field_validations["variant-of"])
  end

  defp show_status(%{status: "ok"} = standards), do: html_escape(Jason.encode!(standards.value))
  defp show_status(%{status: status}), do: status

end

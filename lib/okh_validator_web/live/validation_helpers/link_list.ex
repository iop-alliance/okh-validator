defmodule OkhValidatorWeb.ValidationHelpers.LinkList do
  use Phoenix.HTML

  # alias OkhValidatorWeb.ValidationHelpers.TextField

  def show_validation_result(field) do
    show_status(field)
  end

  defp show_status(%{status: "ok"} = field), do: html_escape(Jason.encode!(field.value))
  defp show_status(%{status: status}), do: status

end

defmodule OkhValidatorWeb.V1ValidationHelpers.Person do
  use Phoenix.HTML

  def show_validation_result(field) do
    show_status(field)
  end

  defp show_status(%{status: "ok"} = field), do: check_validations(field)
  defp show_status(%{status: status}), do: status

  defp check_validations(%{status: "ok"} = field) do
    raw(
      "<ul><li>Name: #{field.value["name"]}</li>" <>
      "<li>Email: #{field.value["email"]}</li>" <>
      "<li>Affiliation: #{field.value["affiliation"]}</li></ul>"
    )
  end
  defp check_validations(%{status: "error"} = field) do
    raw("<span class=\"text-danger\">Error: #{field.message}</span>")
  end
end

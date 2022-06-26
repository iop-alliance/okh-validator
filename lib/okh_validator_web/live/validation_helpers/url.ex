defmodule OkhValidatorWeb.ValidationHelpers.URL do
  use Phoenix.HTML

  def show_validation_result(%{status: "ok"} = field), do: content_tag(:a, field.value, href: field.value)
  def show_validation_result(%{status: status}), do: status
end

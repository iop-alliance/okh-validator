defmodule OkhValidatorWeb.ValidationHelpers.TextField do
  use Phoenix.HTML

  def show_validation_result(%{status: "ok"} = field), do: field.value
  def show_validation_result(%{status: "error"} = field), do: content_tag(:p, "#{field.message} (#{field.value})", class: "text-danger")
  def show_validation_result(%{status: status}), do: status
end

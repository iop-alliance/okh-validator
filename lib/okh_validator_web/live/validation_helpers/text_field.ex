defmodule OkhValidatorWeb.ValidationHelpers.TextField do
  def show_validation_result(%{status: "ok"} = field), do: field.value
  def show_validation_result(%{status: status}), do: status
end

defmodule OkhValidatorWeb.ValidationHelpers.Image do
  use Phoenix.HTML

  def show_validation_result(%{status: "ok"} = field), do: img_tag(field.value, style: "max-height: 250px;")
  def show_validation_result(%{status: status}), do: status
end

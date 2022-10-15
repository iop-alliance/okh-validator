defmodule OkhValidatorWeb.V1ValidationHelpers.Image do
  use Phoenix.HTML

  def show_validation_result(%{status: "ok"} = field) do
    content_tag :div do
      [
        img_tag(field.value, style: "max-height: 250px;"),
        content_tag :div do
          content_tag(:a, field.value, href: field.value)
        end
      ]
    end
  end
  def show_validation_result(%{status: status}), do: status
end

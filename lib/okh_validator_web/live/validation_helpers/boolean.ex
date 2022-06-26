defmodule OkhValidatorWeb.ValidationHelpers.Boolean do
  use Phoenix.HTML

  def show_validation_result(%{status: "ok"} = field) do
    case field.value  do
      true -> "Yes"
      _ -> "No"
    end
  end
  def show_validation_result(%{status: status}), do: status
end

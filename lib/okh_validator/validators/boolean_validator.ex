defmodule Validators.BooleanValidator do

  def validate_boolean(validations, fields, field_list) when is_list(field_list) do
    validations_list = Enum.map(field_list, &(validate_boolean(validations, fields, &1)))
    Map.merge(validations, Enum.reduce(validations_list, &Map.merge/2))
  end

  def validate_boolean(validations, fields, field) do
    case Map.get(fields, field) do
      nil ->
        Map.merge(validations, %{field => %{status: "not found"}})
      _ ->
        %{^field => value} = fields
        Map.merge(validations, %{field => check_valid_boolean(value)})
    end
  end

  defp check_valid_boolean(field) do
    case is_boolean(field) do
      true ->
        %{status: "ok", value: field}
      _ ->
        %{status: "error", message: "not valid boolean", value: field}
    end
  end
end

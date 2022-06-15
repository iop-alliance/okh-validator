defmodule Validators.ArrayValidator do

  def validate_array_field(validations, fields, field_list) when is_list(field_list) do
    validations_list = Enum.map(field_list, &(validate_array_field(validations, fields, &1)))
    Map.merge(validations, Enum.reduce(validations_list, &Map.merge/2))
  end


  def validate_array_field(validations, fields, field) do
    case Map.get(fields, field) do
      nil ->
        Map.merge(validations, %{field => %{status: "not found"}})
      _ ->
        %{^field => value} = fields
        Map.merge(validations, validate_array(value, field))
    end
  end

  defp validate_array(maybe_array, field) do
    case is_list(maybe_array) do
      true ->
        %{field => %{status: "ok", value: maybe_array}}
      false ->
        %{field => %{status: "error", message: "Not a valid array", value: maybe_array}}
    end
  end

end

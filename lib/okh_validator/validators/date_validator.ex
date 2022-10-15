defmodule Validators.DateValidator do
  alias V1ValidationHelpers

  def validate_date(validations, fields, field_list) when is_list(field_list) do
    validations_list = Enum.map(field_list, &(validate_date(validations, fields, &1)))
    Map.merge(validations, Enum.reduce(validations_list, &Map.merge/2))
  end

  def validate_date(validations, fields, field) do
    case Map.get(fields, field) do
      nil ->
        Map.merge(validations, %{field => %{status: "not found"}})
      _ ->
        %{^field => value} = fields
        Map.merge(validations, V1ValidationHelpers.validate_date(value, field))
    end
  end
end

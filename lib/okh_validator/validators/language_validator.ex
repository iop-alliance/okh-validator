defmodule Validators.LanguageValidator do
  # TODO add validations for correect laguage code
  # see:
  #   - https://gist.github.com/delameko/aa2126660074459d120f21ab8cf3ae26
  #   - https://gist.github.com/delameko/1af83137c37087bd3ab6a0447448ba6e

  def validate_language(validations, fields, field_list) when is_list(field_list) do
    validations_list = Enum.map(field_list, &(validate_language(validations, fields, &1)))
    Map.merge(validations, Enum.reduce(validations_list, &Map.merge/2))
  end

  def validate_language(validations, fields, field) do
    case Map.get(fields, field) do
      nil ->
        Map.merge(validations, %{field => %{status: "not found"}})
      _ ->
        %{^field => value} = fields

        Map.merge(validations, %{field => %{status: "ok", value: value}})
    end
  end
end

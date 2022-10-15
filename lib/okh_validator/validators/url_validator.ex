defmodule Validators.UrlValidator do
  alias V1ValidationHelpers

  def validate_url(validations, fields, field_list) when is_list(field_list) do
    validations_list = Enum.map(field_list, &(validate_url(validations, fields, &1)))
    Map.merge(validations, Enum.reduce(validations_list, &Map.merge/2))
  end

  def validate_url(validations, fields, field) do
    case Map.get(fields, field) do
      nil ->
        Map.merge(validations, %{field => %{status: "not found"}})
      _ ->
        %{^field => value} = fields
        Map.merge(validations, %{field => check_url(value)})
    end
  end

  defp check_url(maybe_url) do
    case HTTPoison.get(maybe_url) do
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        %{status: "error", message: "404 error: URL not found", value: maybe_url}
      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        %{status: "ok", value: maybe_url, http_status: status_code}
      {:error, %HTTPoison.Error{reason: reason}} ->
        %{status: "error", message: reason, value: maybe_url}
      end
  end
end

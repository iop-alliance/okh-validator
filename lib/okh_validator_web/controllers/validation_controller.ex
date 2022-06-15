defmodule OkhValidatorWeb.ValidationController do
  use OkhValidatorWeb, :controller

  alias OkhValidator.OkhManifest

  def index(conn, params) do

    validation_response =
      with {:ok, manifest_url} <- validate_manifest_param(params),
        {:ok, manifest_content} <- get_manifest(manifest_url),
        {:ok, manifest_data} <- validate_yaml(manifest_content) do
          %{
            manifest_url: manifest_url,
            data: manifest_data
          }
          |> Map.merge(validate_manifest(manifest_data))

      else {:error, error} ->
        error
      end

    render(conn, "index.json", validation_response: validation_response)
  end

  defp validate_manifest_param(params) do
      case params |> Map.has_key?("manifest") do
        false ->
          {:error, %{status: "error", message: "Manifest parameter not provided"}}
        true ->
          {:ok, params["manifest"]}
      end
  end

  defp get_manifest(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, %{status: "error", message: "404: manifest URL not found"}}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{status: "error", message: reason}}
    end
  end

  defp validate_yaml(manifest) do
    {status, response} = YamlElixir.read_from_string(manifest)
    case status do
      :ok ->
        {:ok, response}
      :error ->
        {:error, %{status: "error", message: "Error parsing YAML" ,reason: response |> Map.delete(:__exception__) |> Map.from_struct()}}
    end
  end

  defp validate_manifest(manifest) do
    OkhManifest.validate_manifest(manifest)
  end
end

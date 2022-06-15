defmodule OkhValidatorWeb.PageLive do
  use OkhValidatorWeb, :live_view

  alias OkhValidator.OkhManifest

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        manifest_url: "",
        url_validation: %{message: ""},
        manifest_raw_content: "",
        yaml_validation: %{message: "No YAML parsed"},
        manifest_data: %{},
        loading: false
      )
    {:ok, socket}
  end

  @impl true
  def handle_event("validate-manifest", %{"manifest_url" => manifest_url}, socket) do

    {_, socket} = validate_url(manifest_url, socket)

    {_, socket} =
      case socket.assigns.url_validation.status do
        "ok" ->
          validate_yaml(socket)
        _ -> {:noreply, socket}
      end

    socket = assign(socket,
      manifest_url: manifest_url
    )

    {:noreply, socket}
  end

  defp validate_url(url, socket) do
    {status, response} = get_manifest(url)

    case status do
      :ok ->
        socket = assign(socket,
          url_validation: %{status: "ok", message: "Valid"},
          manifest_raw_content: response
        )
        {:noreply, socket}
      :error ->
        socket =
          socket
          |> assign(url_validation: %{status: "error", message: "Not valid — " <> response[:message]})
          {:noreply, socket}
    end

  end

  defp validate_yaml(socket) do
    {status, response} = YamlElixir.read_from_string(socket.assigns.manifest_raw_content)
    case status do
      :ok ->
        socket =
          socket
          |> assign(yaml_validation: %{status: "ok", message: "Manifest is valid YAML"})
          |> assign(manifest_data: response)
        {:noreply, socket}
      :error ->
        socket =
          socket
          |> assign(yaml_validation: %{status: "error",
                                      message: "Error parsing YAML",
                                      reason: response |> Map.delete(:__exception__) |> Map.from_struct()})
        {:noreply, socket}
    end


  end

  def get_manifest(manifest_url) do
    case HTTPoison.get(manifest_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, %{status: "error", message: "404: URL not found"}}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{status: "error", message: to_string(reason)}}
    end
  end

  defp validate_manifest(manifest) do
    OkhManifest.validate_manifest(manifest)
  end
end

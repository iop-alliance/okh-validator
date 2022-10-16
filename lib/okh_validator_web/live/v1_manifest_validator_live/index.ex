defmodule OkhValidatorWeb.V1ManifestValidatorLive.Index do
  use OkhValidatorWeb, :live_view

  alias OkhValidator.OkhManifest
  alias OkhValidator.Converters.Oshwa
  # alias OkhValidator.Manifest

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> initialise_results
      |> assign(
          manifest_url: "",
          loading: false,
          page_title: "OKH v1 Validator"
        )
    {:ok, socket}
  end

  @impl true
  def handle_event("validate-manifest", %{"manifest_url" => manifest_url}, socket) do
    initialise_results(socket)

    {_, socket} = validate_url(manifest_url, socket)

    {_, socket} =
      case socket.assigns.url_validation.status do
        "ok" ->
          validate_yaml(socket)
        _ -> {:noreply, socket}
      end

    {_, socket} =
      case socket.assigns.yaml_validation.status do
        "ok" ->
          validate_manifest(socket)
        _ -> {:noreply, socket}
      end

    IO.inspect(socket.assigns.validations)
    socket = assign(socket,
      manifest_url: manifest_url
    )

    {:noreply, socket}
  end

  @impl true
  def handle_event("convert-to-oshwa", _, socket) do
    {:ok, oshwa_project} = Oshwa.convert_okh_to_oshwa(socket.assigns.manifest_data)
    socket = assign(socket, oshwa_project: oshwa_project)
    {:noreply, socket}
  end

  defp initialise_results(socket) do
    assign(socket, %{
      url_validation: %{status: "", message: ""},
      manifest_raw_content: "",
      yaml_validation: %{status: "", message: "No YAML parsed"},
      manifest_data: %{},
      validations: %{},
      oshwa_project: %{}
    })
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

  defp get_manifest(manifest_url) do
    case HTTPoison.get(manifest_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, %{status: "error", message: "404: URL not found"}}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{status: "error", message: to_string(reason)}}
    end
  end

  defp validate_manifest(socket) do
    socket = assign(socket, validations: OkhManifest.validate_manifest(socket.assigns.manifest_data))
    {:ok, socket}
  end
end

defmodule OkhValidatorWeb.Manifest_v1Live.Index do
  use OkhValidatorWeb, :live_view

  alias OkhValidator.Manifest
  alias OkhValidator.Manifest.Manifest_v1

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :manifests_v1, list_manifests_v1())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Manifest v1")
    |> assign(:manifest_v1, Manifest.get_manifest_v1!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Manifest v1")
    |> assign(:manifest_v1, %Manifest_v1{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Manifests v1")
    |> assign(:manifest_v1, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    manifest_v1 = Manifest.get_manifest_v1!(id)
    {:ok, _} = Manifest.delete_manifest_v1(manifest_v1)

    {:noreply, assign(socket, :manifests_v1, list_manifests_v1())}
  end

  defp list_manifests_v1 do
    Manifest.list_manifests_v1()
  end
end

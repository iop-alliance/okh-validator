defmodule OkhValidatorWeb.Manifest_v1Live.Show do
  use OkhValidatorWeb, :live_view

  alias OkhValidator.Manifest

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:manifest_v1, Manifest.get_manifest_v1!(id))}
  end

  defp page_title(:show), do: "Show Manifest v1"
  defp page_title(:edit), do: "Edit Manifest v1"
end

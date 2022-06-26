defmodule OkhValidatorWeb.Manifest_v1Live.FormComponent do
  use OkhValidatorWeb, :live_component

  alias OkhValidator.Manifest

  @impl true
  def update(%{manifest_v1: manifest_v1} = assigns, socket) do
    changeset = Manifest.change_manifest_v1(manifest_v1)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"manifest_v1" => manifest_v1_params}, socket) do
    changeset =
      socket.assigns.manifest_v1
      |> Manifest.change_manifest_v1(manifest_v1_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"manifest_v1" => manifest_v1_params}, socket) do
    save_manifest_v1(socket, socket.assigns.action, manifest_v1_params)
  end

  defp save_manifest_v1(socket, :edit, manifest_v1_params) do
    case Manifest.update_manifest_v1(socket.assigns.manifest_v1, manifest_v1_params) do
      {:ok, _manifest_v1} ->
        {:noreply,
         socket
         |> put_flash(:info, "Manifest v1 updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_manifest_v1(socket, :new, manifest_v1_params) do
    case Manifest.create_manifest_v1(manifest_v1_params) do
      {:ok, _manifest_v1} ->
        {:noreply,
         socket
         |> put_flash(:info, "Manifest v1 created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

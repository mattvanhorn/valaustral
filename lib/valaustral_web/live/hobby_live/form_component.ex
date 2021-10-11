defmodule ValaustralWeb.HobbyLive.FormComponent do
  use ValaustralWeb, :live_component

  alias Valaustral.Hobbies

  @impl true
  def update(%{hobby: hobby} = assigns, socket) do
    changeset = Hobbies.change_hobby(hobby)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"hobby" => hobby_params}, socket) do
    changeset =
      socket.assigns.hobby
      |> Map.put(:user_id, socket.assigns.current_user.id)
      |> Hobbies.change_hobby(hobby_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"hobby" => hobby_params}, socket) do
    save_hobby(
      socket,
      socket.assigns.action,
      Map.put(hobby_params, "user_id", socket.assigns.current_user.id)
    )
  end

  defp save_hobby(socket, :edit, hobby_params) do
    case Hobbies.update_hobby(socket.assigns.hobby, hobby_params) do
      {:ok, _hobby} ->
        {:noreply,
         socket
         |> put_flash(:info, "Hobby updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_hobby(socket, :new, hobby_params) do
    case Hobbies.create_hobby(hobby_params) do
      {:ok, _hobby} ->
        {:noreply,
         socket
         |> put_flash(:info, "Hobby created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

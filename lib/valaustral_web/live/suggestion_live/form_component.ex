defmodule ValaustralWeb.SuggestionLive.FormComponent do
  use ValaustralWeb, :live_component

  alias Valaustral.Suggestions

  @impl true
  def update(%{suggestion: suggestion} = assigns, socket) do
    changeset = Suggestions.change_suggestion(suggestion)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"suggestion" => suggestion_params}, socket) do
    changeset =
      socket.assigns.suggestion
      |> Suggestions.change_suggestion(suggestion_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"suggestion" => suggestion_params}, socket) do
    save_suggestion(socket, socket.assigns.action, suggestion_params)
  end

  defp save_suggestion(socket, :edit, suggestion_params) do
    case Suggestions.update_suggestion(socket.assigns.suggestion, suggestion_params) do
      {:ok, _suggestion} ->
        {:noreply,
         socket
         |> put_flash(:info, "Suggestion updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_suggestion(socket, :new, suggestion_params) do
    case Suggestions.create_suggestion(suggestion_params) do
      {:ok, _suggestion} ->
        {:noreply,
         socket
         |> put_flash(:info, "Suggestion created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

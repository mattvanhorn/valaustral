defmodule ValaustralWeb.SuggestionLive.Index do
  use ValaustralWeb, :live_view

  alias Valaustral.Suggestions
  alias Valaustral.Suggestions.Suggestion

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :suggestions, list_suggestions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Suggestion")
    |> assign(:suggestion, Suggestions.get_suggestion!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Suggestion")
    |> assign(:suggestion, %Suggestion{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Suggestions")
    |> assign(:suggestion, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    suggestion = Suggestions.get_suggestion!(id)
    {:ok, _} = Suggestions.delete_suggestion(suggestion)

    {:noreply, assign(socket, :suggestions, list_suggestions())}
  end

  defp list_suggestions do
    Suggestions.list_suggestions()
  end
end

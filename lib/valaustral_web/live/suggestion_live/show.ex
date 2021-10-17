defmodule ValaustralWeb.SuggestionLive.Show do
  use ValaustralWeb, :live_view

  alias Valaustral.Suggestions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:suggestion, Suggestions.get_suggestion!(id))}
  end

  defp page_title(:show), do: "Show Suggestion"
  defp page_title(:edit), do: "Edit Suggestion"
end

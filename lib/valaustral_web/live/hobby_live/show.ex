defmodule ValaustralWeb.HobbyLive.Show do
  use ValaustralWeb, :live_view

  alias Valaustral.Hobbies

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:hobby, Hobbies.get_hobby!(id))}
  end

  defp page_title(:show), do: "Show Hobby"
  defp page_title(:edit), do: "Edit Hobby"
end

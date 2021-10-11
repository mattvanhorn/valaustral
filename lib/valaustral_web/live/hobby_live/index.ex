defmodule ValaustralWeb.HobbyLive.Index do
  use ValaustralWeb, :live_view

  alias Valaustral.Hobbies
  alias Valaustral.Hobbies.Hobby

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :hobbies, list_user_hobbies(socket.assigns.current_user))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Hobby")
    |> assign(:hobby, Hobbies.get_hobby!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Hobby")
    |> assign(:hobby, %Hobby{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Hobbies")
    |> assign(:hobby, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    hobby = Hobbies.get_hobby!(id)
    {:ok, _} = Hobbies.delete_hobby(hobby)

    {:noreply, assign(socket, :hobbies, list_user_hobbies(socket.assigns.current_user))}
  end

  defp list_user_hobbies(user) do
    Hobbies.list_user_hobbies(user)
  end
end

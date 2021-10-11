defmodule ValaustralWeb.UserLiveAuth do
  import Phoenix.LiveView

  alias Valaustral.Accounts

  def mount(_params, %{"user_token" => user_token} = _session, socket) do
    socket =
      assign_new(socket, :current_user, fn ->
        Accounts.get_user_by_session_token(user_token)
      end)

    if socket.assigns.current_user do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: "/users/log_in")}
    end
  end
end

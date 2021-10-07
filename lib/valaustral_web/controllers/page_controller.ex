defmodule ValaustralWeb.PageController do
  use ValaustralWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

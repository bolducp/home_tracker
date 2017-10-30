defmodule HomeTrackerWeb.SessionController do
  use HomeTrackerWeb, :controller

  def new(conn, _params) do
    conn |> render("new.html")
  end
end

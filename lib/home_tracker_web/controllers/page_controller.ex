defmodule HomeTrackerWeb.PageController do
  use HomeTrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

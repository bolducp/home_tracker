defmodule HomeTrackerWeb.Plugs.LoadUser do
  import Plug.Conn
  import Phoenix.Controller

  alias HomeTracker.Repo
  alias HomeTracker.Accounts

  def init(_params) do
  end

  def call(conn, _params) do
    case conn |> get_session(:user_token) do
      nil -> conn
      token -> conn |> _load_user(Accounts.get_user_from_token(token))
    end
  end

  def _load_user(conn, nil), do: conn
  def _load_user(conn, user), do: conn |> assign(:user, user)
end

defmodule HomeTrackerWeb.SessionController do
  use HomeTrackerWeb, :controller
  alias HomeTrackerWeb.Accounts

  def new(conn, _params) do
    changeset = Accounts.new_session()

    conn |> render("new.html", changeset: changeset)
  end

def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
   case Accounts.create_session(email, password) do
     {:ok, user} ->
       conn
       |> put_session(:token, user.token)
       |> redirect(to: home_path(conn, :index))
     {:error, _} ->
       changeset = Accounts.new_session()
       conn
       |> put_status(403)
       |> render("new.html", changeset: changeset)
   end
 end
end

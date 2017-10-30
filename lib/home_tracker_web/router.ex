defmodule HomeTrackerWeb.Router do
  use HomeTrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug HomeTrackerWeb.Plugs.LoadUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HomeTrackerWeb do
    pipe_through [:browser, :authenticate_user]

    get "/", HomeController, :index
    resources "/users", UserController
  end

  scope "/sessions", HomeTrackerWeb do
    pipe_through [:browser]
    resources "/", SessionController, only: [:new, :create]
  end

  defp authenticate_user(conn, _) do
    case Map.has_key?(conn.assigns, :user) do
      true -> conn
      false -> conn |> Phoenix.Controller.put_flash(:error, "Login required") |> Phoenix.Controller.redirect(to: "/sessions/new") |> halt()
    end
  end
end

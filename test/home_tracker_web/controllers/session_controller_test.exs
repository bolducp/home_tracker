defmodule HomeTrackerWeb.SessionControllerTest do
  use HomeTrackerWeb.ConnCase

  test "create a new session - no user found", %{conn: conn} do
    params = %{
      "user" => %{
        "email" => "user@example.com",
        "password" => "password",
      },
    }
    conn = post conn, session_path(conn, :create), params
    assert html_response(conn, 403)
  end

  test "create a new session - user exists", %{conn: conn} do
    user = create_user(%{"email" => "user@example.com", "password" => "password", "name" => "Priya Joe"})
    params = %{
      "user" => %{
        "email" => user.email,
        "password" => "password",
      },
    }
    conn = post conn, session_path(conn, :create), params
    assert redirected_to(conn) == home_path(conn, :index)
  end
end

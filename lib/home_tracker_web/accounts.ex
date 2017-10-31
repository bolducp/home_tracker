defmodule HomeTrackerWeb.Accounts do
  @moduledoc """
  Context interface for Accounts in the web app.
  """
  alias HomeTracker.Repo
  alias HomeTracker.Accounts
  alias HomeTracker.Accounts.User

  def new_session() do
    %User{}
    |> User.changeset()
  end

  @doc """
  Creates a new session for a user.
  Checks the email/password and if they match a user, get a new session token and
  insert it into the user record.
  """
  def create_session(email, password) do
    with {:ok, user} <- Accounts.check_password(email, password),
         changeset = User.session_changeset(user, %{"token" => Accounts.generate_token()}),
         {:ok, user} <- Repo.update(changeset) do
      {:ok, user}
    else
      {:error, e} ->
        # Catch-all for errors in either of password creation or Repo.insert.
        {:error, e}
    end
  end
end

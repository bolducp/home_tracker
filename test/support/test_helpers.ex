defmodule HomeTracker.TestHelpers do
  alias HomeTracker.Accounts.User
  alias HomeTracker.Repo

  def create_user(attributes) do
    %User{}
    |> User.changeset(attributes)
    |> Repo.insert!()
  end
end

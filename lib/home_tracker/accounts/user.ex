defmodule HomeTracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :token, Ecto.UUID

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :password])
    |> validate_required([:email, :password])
    |> ensure_token()
    |> hash_password()
    |> unique_constraint(:email)
    |> unique_constraint(:token)
  end

  defp ensure_token(changeset) do
    case changeset do
      %{changes: %{token: _token}} -> changeset
      %{data: %{token: token}} when token != nil -> changeset
      _ -> put_change(changeset, :token, UUID.uuid4())
    end
  end

  defp hash_password(changeset) do
    case changeset do
      %{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end

  def session_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:token])
    |> validate_required([:token])
    |> unique_constraint(:token)
  end
end

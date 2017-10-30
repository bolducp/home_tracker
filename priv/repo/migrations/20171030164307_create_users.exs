defmodule HomeTracker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :token, :uuid, null: false

      timestamps()
    end

    create index(:users, :email, unique: true)
    create index(:users, :token, unique: true)
  end
end

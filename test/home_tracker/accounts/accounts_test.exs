defmodule HomeTracker.AccountsTest do
  use HomeTracker.DataCase

  alias HomeTracker.Accounts

  describe "users" do
    alias HomeTracker.Accounts.User

    @valid_attrs %{name: "some name", email: "example@email.com", password: "password"}
    @update_attrs %{name: "some updated name", email: "example@email.com"}
    @invalid_attrs %{name: nil, email: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert length(Accounts.list_users()) == 1
      assert List.first(Accounts.list_users()).id == user.id
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id).password == nil
      assert Accounts.get_user!(user.id).name == user.name
      assert Accounts.get_user!(user.id).email == user.email
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.name == "some name"
      assert user.email == "example@email.com"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert Accounts.get_user!(user.id).password == nil
      assert Accounts.get_user!(user.id).name == user.name
      assert Accounts.get_user!(user.id).email == user.email
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end

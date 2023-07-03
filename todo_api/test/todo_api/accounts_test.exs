defmodule TodoApi.AccountsTest do
  use TodoApi.DataCase

  alias TodoApi.Accounts

  describe "accounts" do
    alias TodoApi.Accounts.Account

    import TodoApi.AccountsFixtures

    @invalid_attrs %{password: nil, email: nil, fullname: nil, nickname: nil, last_login: nil, last_login_ip: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{password: "some password", email: "some email", fullname: "some fullname", nickname: "some nickname", last_login: ~N[2023-07-02 09:45:00], last_login_ip: "some last_login_ip"}

      assert {:ok, %Account{} = account} = Accounts.create_account(valid_attrs)
      assert account.password == "some password"
      assert account.email == "some email"
      assert account.fullname == "some fullname"
      assert account.nickname == "some nickname"
      assert account.last_login == ~N[2023-07-02 09:45:00]
      assert account.last_login_ip == "some last_login_ip"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{password: "some updated password", email: "some updated email", fullname: "some updated fullname", nickname: "some updated nickname", last_login: ~N[2023-07-03 09:45:00], last_login_ip: "some updated last_login_ip"}

      assert {:ok, %Account{} = account} = Accounts.update_account(account, update_attrs)
      assert account.password == "some updated password"
      assert account.email == "some updated email"
      assert account.fullname == "some updated fullname"
      assert account.nickname == "some updated nickname"
      assert account.last_login == ~N[2023-07-03 09:45:00]
      assert account.last_login_ip == "some updated last_login_ip"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account(account, @invalid_attrs)
      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end
end

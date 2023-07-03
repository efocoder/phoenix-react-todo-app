defmodule TodoApiWeb.AccountControllerTest do
  use TodoApiWeb.ConnCase

  import TodoApi.AccountsFixtures

  alias TodoApi.Accounts.Account

  @create_attrs %{
    password: "some password",
    email: "some email",
    fullname: "some fullname",
    nickname: "some nickname",
    last_login: ~N[2023-07-02 09:45:00],
    last_login_ip: "some last_login_ip"
  }
  @update_attrs %{
    password: "some updated password",
    email: "some updated email",
    fullname: "some updated fullname",
    nickname: "some updated nickname",
    last_login: ~N[2023-07-03 09:45:00],
    last_login_ip: "some updated last_login_ip"
  }
  @invalid_attrs %{password: nil, email: nil, fullname: nil, nickname: nil, last_login: nil, last_login_ip: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, ~p"/api/accounts")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create account" do
    test "renders account when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/accounts", account: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/accounts/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some email",
               "fullname" => "some fullname",
               "last_login" => "2023-07-02T09:45:00",
               "last_login_ip" => "some last_login_ip",
               "nickname" => "some nickname",
               "password" => "some password"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/accounts", account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update account" do
    setup [:create_account]

    test "renders account when data is valid", %{conn: conn, account: %Account{id: id} = account} do
      conn = put(conn, ~p"/api/accounts/#{account}", account: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/accounts/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some updated email",
               "fullname" => "some updated fullname",
               "last_login" => "2023-07-03T09:45:00",
               "last_login_ip" => "some updated last_login_ip",
               "nickname" => "some updated nickname",
               "password" => "some updated password"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, account: account} do
      conn = put(conn, ~p"/api/accounts/#{account}", account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete account" do
    setup [:create_account]

    test "deletes chosen account", %{conn: conn, account: account} do
      conn = delete(conn, ~p"/api/accounts/#{account}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/accounts/#{account}")
      end
    end
  end

  defp create_account(_) do
    account = account_fixture()
    %{account: account}
  end
end

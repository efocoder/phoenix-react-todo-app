defmodule TodoApi.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoApi.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        password: "some password",
        email: "some email",
        fullname: "some fullname",
        nickname: "some nickname",
        last_login: ~N[2023-07-02 09:45:00],
        last_login_ip: "some last_login_ip"
      })
      |> TodoApi.Accounts.create_account()

    account
  end
end

defmodule TodoApiWeb.V1.AccountJSON do
  alias TodoApi.Accounts.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  def access_token(%{account: account, token: token}) do
    %{id: account.id, email: account.email, token: token}
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email,
      fullname: account.fullname,
      nickname: account.nickname,
      last_login: account.last_login,
      last_login_ip: account.last_login_ip,
      status: account.status
    }
  end
end

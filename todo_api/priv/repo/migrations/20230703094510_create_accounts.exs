defmodule TodoApi.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string, nullable: false
      add :fullname, :string, nullable: false
      add :nickname, :string, nullable: false
      add :password, :string, nullable: false
      add :last_login, :naive_datetime
      add :last_login_ip, :inet
      add :status, :string, nullable: false

      timestamps()
    end
    create unique_index(:accounts, :email)
    create unique_index(:accounts, :nickname)
  end
end

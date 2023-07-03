defmodule TodoApi.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias TodoApi.Todos.Todo

  @email_regex ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
  @password_regex ~r/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/



  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :password, :string
    field :email, :string
    field :fullname, :string
    field :nickname, :string
    field :last_login, :naive_datetime
    field :last_login_ip,  EctoNetwork.INET
    field :status,  Ecto.Enum, values: [:A, :D], default: :A
    has_many :todos, Todo

    timestamps()

  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:email, :fullname, :nickname, :password, :last_login, :last_login_ip, :status])
    |> validate_required([:email, :fullname, :nickname, :password])
    |> validate_format(:email, @email_regex)
    |> validate_format(:fullname, ~r/^[a-zA-Z ]+$/)
    |> validate_format(:nickname, ~r/^[a-zA-Z0-9]+$/)
    |> unique_constraint(:email)
    |> unique_constraint(:nickname)
    |> validate_format(:password, @password_regex)
    |> validate_length(:nickname, max: 6)
    |> put_password_hash()
  end

  @doc false
  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  @doc false
  defp put_password_hash(changeset), do: changeset
end

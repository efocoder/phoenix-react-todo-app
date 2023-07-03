defmodule TodoApi.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  alias TodoApi.Accounts.Account

  @derive {
    Flop.Schema,
    filterable: [:name, :progress], sortable: [:name, :progress], max_limit: 10, default_limit: 2
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "todos" do
    field :status, Ecto.Enum, values: [:A, :D], default: :A
    field :progress, Ecto.Enum, values: [:To_do, :In_progress, :Done, :Cancelled], default: :To_do
    field :description, :string
    field :name, :string
    belongs_to :account, Account

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:name, :description, :status, :progress, :account_id])
    |> validate_required([:name, :description, :account_id])
  end
end

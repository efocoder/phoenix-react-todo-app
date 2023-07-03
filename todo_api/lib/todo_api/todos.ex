defmodule TodoApi.Todos do
  @moduledoc """
  The Todos context.
  """

  import Ecto.Query, warn: false
  alias TodoApi.Repo

  alias TodoApi.Todos.Todo
  alias TodoApiWeb.Auth.ErrorResponse


  @doc """
  Returns the list of todos.

  ## Examples

      iex> list_todos()
      [%Todo{}, ...]

  """
  def list_todos(account, params) do
    Todo
    |> where(account_id: ^account.id, status: ^"A")
    |> preload(:account)
    |> Flop.validate_and_run(params, for: Todo, repo: Repo)
  end

  @doc """
  Gets a single todo.

  Raises `ErrorResponse.NotFound` if the Todo does not exist.

  ## Examples

      iex> get_todo!(123)
      %Todo{}

      iex> get_todo!(456)
      ** (ErrorResponse.NotFound)

  """
  def get_todo!(id, account) do
#    Repo.get!(Todo, id)
    Todo
    |> where(id: ^id, account_id: ^account.id, status: ^"A")
    |> preload(:account)
    |> Repo.one()
    |> case do
         todo when not is_nil(todo) ->
           todo

         nil ->
           raise ErrorResponse.NotFound, message: "Todo not found"
       end
  end



  @doc """
  Creates a todo.

  ## Examples

      iex> create_todo(%{field: value})
      {:ok, %Todo{}}

      iex> create_todo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_todo(attrs \\ %{}) do
    %Todo{}
    |> Todo.changeset(attrs)
    |> Repo.insert()
    |> case do
         {:ok, todo} -> {:ok, Repo.preload(todo, :account)}
         error -> error
    end
  end

  @doc """
  Updates a todo.

  ## Examples

      iex> update_todo(todo, %{field: new_value})
      {:ok, %Todo{}}

      iex> update_todo(todo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_todo(%Todo{} = todo, attrs) do
    todo
    |> Todo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a todo.

  ## Examples

      iex> delete_todo(todo)
      {:ok, %Todo{}}

      iex> delete_todo(todo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_todo(%Todo{} = todo) do
    todo
    |> Todo.changeset(%{status: :D})
    |> Repo.update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking todo changes.

  ## Examples

      iex> change_todo(todo)
      %Ecto.Changeset{data: %Todo{}}

  """
  def change_todo(%Todo{} = todo, attrs \\ %{}) do
    Todo.changeset(todo, attrs)
  end
end

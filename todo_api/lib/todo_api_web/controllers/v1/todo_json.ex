defmodule TodoApiWeb.V1.TodoJSON do
  alias TodoApi.Todos.Todo
  alias TodoApiWeb.Paginator


  @doc """
  Renders a list of todos.
  """
  def index(%{todos: todos, meta: meta}) do
    Map.merge(Paginator.paginate(meta, "todos"), %{
      data: for(todo <- todos, do: data(todo))
    })
#    %{data: for(todo <- todos, do: data(todo))}
  end

  @doc """
  Renders a single todo.
  """
  def show(%{todo: todo}) do
    %{data: data(todo)}
  end

  defp data(%Todo{} = todo) do
    %{
      id: todo.id,
      name: todo.name,
      description: todo.description,
      progress: todo.progress,
      owner: %{
        id: todo.account.id,
        fullname: todo.account.fullname,
        nickname: todo.account.nickname
      }
    }
  end
end

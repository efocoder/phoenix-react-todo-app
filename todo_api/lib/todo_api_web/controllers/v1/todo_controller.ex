defmodule TodoApiWeb.V1.TodoController do
  use TodoApiWeb, :controller

  alias TodoApi.Todos
  alias TodoApi.Todos.Todo


  action_fallback TodoApiWeb.FallbackController

  def index(conn, params) do
    with {:ok, {todos, meta}} <-  Todos.list_todos(Guardian.Plug.current_resource(conn), params) do
      conn
      |> put_status(:ok)
      |> render(:index, meta: meta, todos: todos)
    end
  end

  def create(conn, %{"todo" => todo_params}) do
    with {:ok, %Todo{} = todo} <- Todos.create_todo(Map.merge(todo_params, %{"account_id" => Guardian.Plug.current_resource(conn).id})) do
      conn
      |> put_status(:created)
      |> render(:show, todo: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id, Guardian.Plug.current_resource(conn))
    render(conn, :show, todo: todo)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Todos.get_todo!(id, Guardian.Plug.current_resource(conn))

    with {:ok, %Todo{} = todo} <- Todos.update_todo(todo, todo_params) do
      render(conn, :show, todo: todo)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id, Guardian.Plug.current_resource(conn))

    with {:ok, %Todo{}} <- Todos.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end
end

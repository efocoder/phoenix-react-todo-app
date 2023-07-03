defmodule TodoApi.TodosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoApi.Todos` context.
  """

  @doc """
  Generate a todo.
  """
  def todo_fixture(attrs \\ %{}) do
    {:ok, todo} =
      attrs
      |> Enum.into(%{
        status: "some status",
        description: "some description",
        title: "some title"
      })
      |> TodoApi.Todos.create_todo()

    todo
  end
end

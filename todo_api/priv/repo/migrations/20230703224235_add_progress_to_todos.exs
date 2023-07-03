defmodule TodoApi.Repo.Migrations.AddProgressToTodos do
  use Ecto.Migration

  def change do
    alter table(:todos) do
      add :progress, :string, nullable: false
    end
  end
end

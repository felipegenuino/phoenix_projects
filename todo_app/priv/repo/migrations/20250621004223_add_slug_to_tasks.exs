defmodule TodoApp.Repo.Migrations.AddSlugToTasks do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :slug, :string
    end

    create unique_index(:tasks, [:slug])
  end

end

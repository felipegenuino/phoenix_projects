defmodule TodoApp.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoApp.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        description: "some description",
        done: true,
        title: "some title"
      })
      |> TodoApp.Tasks.create_task()

    task
  end
end

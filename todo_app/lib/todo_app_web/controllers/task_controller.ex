defmodule TodoAppWeb.TaskController do
  use TodoAppWeb, :controller

  alias TodoApp.Tasks
  alias TodoApp.Tasks.Task

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    render(conn, :index, tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: ~p"/tasks/#{task.slug}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => slug}) do
    task = Tasks.get_task_by_slug!(slug)
    render(conn, :show, task: task)
  end

  def edit(conn, %{"id" => slug}) do
    task = Tasks.get_task_by_slug!(slug)
    changeset = Tasks.change_task(task)
    render(conn, :edit, task: task, changeset: changeset, action: ~p"/tasks/#{task.slug}")
  end

  def update(conn, %{"id" => slug, "task" => task_params}) do
    task = Tasks.get_task_by_slug!(slug)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: ~p"/tasks/#{task.slug}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => slug}) do
    task = Tasks.get_task_by_slug!(slug)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: ~p"/tasks")
  end
end

defmodule TodoApp.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :slug, :string
    field :done, :boolean, default: false
    field :description, :string
    field :title, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :done])
    |> validate_required([:title, :description, :done])
    |> put_slug()
  end

  defp put_slug(changeset) do
    if title = get_change(changeset, :title) do
      slug =
        title
        |> String.downcase()
        |> String.replace(~r/[^\w\s-]/u, "")
        |> String.replace(" ", "-")
      put_change(changeset, :slug, slug)
    else
      changeset
    end
  end


end

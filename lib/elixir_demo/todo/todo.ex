defmodule ElixirDemo.Todo do
  alias ElixirDemo.Repo
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "todo" do
    field :description, :string
    field :title, :string
    field :is_done, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :description, :is_done])
    |> validate_required([:title, :description, :is_done])
  end

  def create_todo(title, description \\ nil) do
    Repo.insert(%__MODULE__{
      title: title,
      description: description,
      is_done: false
    })
  end

  def mark_todo(id) do
    # The ! that follow one and update are to indicate functions that raise an exception when an entry is not found or cannot be updated respectively.
    # You can change it to make it return an :error instead but I didn't do that here.
    todo = Repo.one!(from t in __MODULE__, where: t.id == ^id)
    updated_todo = Ecto.Changeset.change(todo, is_done: !todo.is_done)
    Repo.update!(updated_todo)
  end

  def delete_todo(id) do
    Repo.delete!(from t in __MODULE__, where: t.id == ^id)
  end

  def get_items() do
    Repo.all(__MODULE__)
  end
end

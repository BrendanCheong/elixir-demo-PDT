defmodule ElixirDemoWeb.PageController do
  use ElixirDemoWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def todo(conn, _params) do
    render(
      conn,
      :todo,
      layout: false,
      todo_list: ElixirDemo.Todo.get_items()
    )
  end
end

defmodule ElixirDemoWeb.TodoController do
  use ElixirDemoWeb, :controller

  def get_todo_list(conn, _params) do
    json(conn, ElixirDemo.Todo.get_items())
  end
end

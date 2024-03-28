defmodule ElixirDemo.Todo do
  alias ElixirDemo.Todo.TodoItem

  def get_items do
    [
      %TodoItem{
        title: "Finish PDT",
        description: "Make sure to finish the PDT before next meeting"
      },
      %TodoItem{
        title: "Integrate AI with FMS",
        description: "Work with the SearchSG team to integrate AI into FMS"
      },
      %TodoItem{
        title: "Finish lunch with the team",
        is_done?: true
      }
    ]
  end
end

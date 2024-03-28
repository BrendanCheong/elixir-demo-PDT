defmodule ElixirDemoWeb.TodoLive do
  alias ElixirDemo.Todo
  use ElixirDemoWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, todo_list: Todo.get_items())
    {:ok, socket, layout: false}
  end

  def handle_event(
        "add-todo",
        %{"task-name" => task_name},
        socket
      ) do
    Todo.create_todo(task_name)
    # `assign` lets us update the socket with new values
    {:noreply, assign(socket, todo_list: Todo.get_items())}
  end

  def handle_event("mark-todo", %{"id" => task_id}, socket) do
    Todo.mark_todo(task_id)
    {:noreply, assign(socket, todo_list: Todo.get_items())}
  end

  def handle_event(
        "delete-todo",
        %{"id" => task_id},
        socket
      ) do
    Todo.delete_todo(task_id)
    {:noreply, assign(socket, todo_list: Todo.get_items())}
  end

  def todo_items(assigns) do
    ~H"""
    <div class="flex mb-4 gap-x-4 last:mb-0">
      <%= if @item.is_done do %>
        <p>✅</p>
      <% else %>
        <p>❌</p>
      <% end %>
      <div class="w-full">
        <div class="flex items-center justify-between w-full">
          <p>
            <%= @item.title %>
          </p>
          <div>
            <%= if @item.is_done do %>
              <button
                phx-value-id={@id}
                phx-click="mark-todo"
                role="button"
                aria-label="Click mark as not done"
                class="cursor-pointer items-center rounded-md border-2 border-black bg-blue-300 px-3 py-1 text-sm font-bold
                  shadow-[4px_4px_0px_0px_rgba(0,0,0,1)] transition-all hover:translate-x-[3px] hover:translate-y-[3px] hover:shadow-none"
              >
                Mark as Not Done
              </button>
            <% else %>
              <button
                phx-value-id={@id}
                phx-click="mark-todo"
                role="button"
                aria-label="Click to mark as done"
                class="cursor-pointer items-center rounded-md border-2 border-black bg-lime-300 px-3 py-1 text-sm font-bold
                  shadow-[4px_4px_0px_0px_rgba(0,0,0,1)] transition-all hover:translate-x-[3px] hover:translate-y-[3px] hover:shadow-none"
              >
                Mark as Done
              </button>
            <% end %>
            <button
              role="button"
              aria-label="Click to edit task"
              class="cursor-pointer items-center rounded-md border-2 border-black bg-amber-300 px-3 py-1 text-sm font-bold
                  shadow-[4px_4px_0px_0px_rgba(0,0,0,1)] transition-all hover:translate-x-[3px] hover:translate-y-[3px] hover:shadow-none"
            >
              Edit
            </button>
            <button
              phx-value-id={@id}
              phx-click="delete-todo"
              role="button"
              aria-label="Click to delete task"
              class="cursor-pointer items-center rounded-md border-2 border-black bg-rose-300 px-3 py-1 text-sm font-bold
                  shadow-[4px_4px_0px_0px_rgba(0,0,0,1)] transition-all hover:translate-x-[3px] hover:translate-y-[3px] hover:shadow-none"
            >
              Delete
            </button>
          </div>
        </div>
        <p class="italic">
          <%= @item.description %>
        </p>
      </div>
    </div>
    """
  end
end

defmodule ElixirDemoWeb.TodoLive do
  alias ElixirDemo.Todo
  alias ElixirDemo.Todo.TodoItem
  use ElixirDemoWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, todo_list: Todo.get_items())
    {:ok, socket, layout: false}
  end

  def handle_event(
        "add-todo",
        %{"task-name" => task_name},
        # todo_list exists in the socket, which was assigned on `mount` function
        %Phoenix.LiveView.Socket{assigns: %{todo_list: todo_list}} = socket
      ) do
    new_todo_list = [%TodoItem{title: task_name}] ++ todo_list

    # `assign` lets us update the socket with new values
    {:noreply, assign(socket, todo_list: new_todo_list)}
  end

  # Elixir lets us add multiple handle_event functions with the same name to handle different events
  def handle_event(
        "mark-not-done",
        %{"id" => task_id},
        %Phoenix.LiveView.Socket{assigns: %{todo_list: todo_list}} = socket
      ) do
    updated_todo_list =
      todo_list
      |> Enum.with_index()
      |> Enum.map(fn {todo, id} ->
        if id == String.to_integer(task_id) do
          # here the pipe operator acts like a Javascript spread operator, where we only update one attribute
          %TodoItem{todo | is_done?: false}
        else
          todo
        end
      end)

    {:noreply, assign(socket, todo_list: updated_todo_list)}
  end

  def handle_event(
        "mark-done",
        %{"id" => task_id},
        %Phoenix.LiveView.Socket{assigns: %{todo_list: todo_list}} = socket
      ) do
    updated_todo_list =
      todo_list
      |> Enum.with_index()
      |> Enum.map(fn {todo, id} ->
        if id == String.to_integer(task_id) do
          %TodoItem{todo | is_done?: true}
        else
          todo
        end
      end)

    {:noreply, assign(socket, todo_list: updated_todo_list)}
  end

  def handle_event(
        "delete-todo",
        %{"id" => task_id},
        %Phoenix.LiveView.Socket{assigns: %{todo_list: todo_list}} = socket
      ) do
    updated_todo_list =
      todo_list
      |> Enum.with_index()
      |> Enum.reject(fn {_, id} -> id == String.to_integer(task_id) end)
      |> Enum.map(fn {todo, _} -> todo end)

    {:noreply, assign(socket, todo_list: updated_todo_list)}
  end

  def todo_items(assigns) do
    ~H"""
    <div class="flex mb-4 gap-x-4 last:mb-0">
      <%= if @item.is_done? do %>
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
            <%= if @item.is_done? do %>
              <button
                phx-value-id={@id}
                phx-click="mark-not-done"
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
                phx-click="mark-done"
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

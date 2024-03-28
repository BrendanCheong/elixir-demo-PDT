defmodule ElixirDemoWeb.PageHTML do
  use ElixirDemoWeb, :html

  embed_templates "page_html/*"

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
                role="button"
                aria-label="Click mark as not done"
                class="cursor-pointer items-center rounded-md border-2 border-black bg-blue-300 px-3 py-1 text-sm font-bold
                  shadow-[4px_4px_0px_0px_rgba(0,0,0,1)] transition-all hover:translate-x-[3px] hover:translate-y-[3px] hover:shadow-none"
              >
                Mark as Not Done
              </button>
            <% else %>
              <button
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

defmodule ElixirDemo.Repo do
  use Ecto.Repo,
    otp_app: :elixir_demo,
    adapter: Ecto.Adapters.SQLite3
end

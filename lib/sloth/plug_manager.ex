defmodule Sloth.PlugManager do
  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def add(module, plugin) do
    Agent.get_and_update(__MODULE__, fn(state) ->
      Map.get_and_update(state, module, fn(value) ->
        case value do
          nil -> {value, plugin}
          _ -> {value, value ++ plugin}
        end
      end)
    end)
  end

  def get(module) do
    Agent.get(__MODULE__, fn(state) -> Map.get(state, module) end)
  end

  def get_all do
    Agent.get(__MODULE__, fn(state) -> state end)
  end
end

defmodule Sloth.Plugin do

  defmacro __using__(_env) do
    quote do
      require Logger
      import Sloth.Plugin
      use GenServer

      @plugin []
      Module.register_attribute(__MODULE__, :plugin, accumulate: true)

      def terminate(reason, state) do
      end

      def handle_cast({:call_plugin, func, args}, state) do
        apply(__MODULE__, func, args)
        {:noreply, state}
      end

      def init(state) do
        {:ok, state}
      end

      @before_compile unquote(__MODULE__)
    end
  end

  defmacro plugin(pattern, function) do
    quote do
      @plugin { unquote(pattern), unquote(function) }
    end
  end

  defmacro __before_compile__(env) do
    quote do
      def start_link do
        Sloth.PlugManager.add(__MODULE__, @plugin)
        GenServer.start_link(__MODULE__, [], name: __MODULE__)
      end
    end
  end

end

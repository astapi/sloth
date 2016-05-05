defmodule Sloth.Slacker do
  use Sloth.Slack
  alias Sloth.PlugManager
  
  def handle_cast({:handle_incoming, type = "message", send_data}, state) do
    Logger.debug "#{type} -> #{inspect send_data}"
    case PlugManager.get_all do
      map when map == %{} -> Logger.debug "Plugin not set"
      map -> each_module(map, send_data)
    end
    {:noreply, state}
  end

  defp each_module(module_map, send_data) when is_map(module_map) do
    Enum.each(module_map, fn({module, functions}) ->
      each_functions(module, functions, send_data)
    end)
  end
  
  defp each_functions(module, functions, send_data) when is_list(functions) do
    Enum.each(functions, fn({regex, func}) ->
      match_function(module, regex, func, send_data)
    end)
  end

  defp match_function(module, regex, func, %{ "text" => text } = send_data) do
    case Regex.run(regex, text) do
      [_text | captures] ->
        GenServer.cast(module, {:call_plugin, func, [send_data, captures]})
      nil ->
        Logger.debug "nothing match #{text}"
    end
  end

end

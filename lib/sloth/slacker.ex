defmodule Sloth.Slacker do
  use Sloth.Slack
  alias Sloth.PlugManager
  
  def handle_cast({:handle_incoming, type = "message", send_data}, state) do
    Logger.debug "#{type} -> #{inspect send_data}"
    PlugManager.get_all
    |> Enum.each(fn({module, functions}) ->
      Enum.each(functions, fn({regex, func}) ->
        match = Regex.run(regex, send_data["text"])
        if match do
          [_text | captures] = match
          GenServer.cast(module, {:call_plugin, func, [send_data, captures]})
        end
      end)
    end)
    {:noreply, state}
  end

end

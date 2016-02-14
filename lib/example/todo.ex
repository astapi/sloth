defmodule Sloth.Todo do
  use Sloth.Plugin

  plugin ~r/^echo (.*)$/, :hogehoge

  def hogehoge(send_data, captures \\ []) do
    Sloth.Slacker.say(send_data["channel"], List.first(captures))
  end

end

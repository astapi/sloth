defmodule Sloth do
  use Application

  def start(_type, _args) do
    Sloth.Supervisor.start_link
  end

end

defmodule Sloth.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    supervise [
      worker(Sloth.Slacker, [Application.get_env(:sloth, :slack_token)]), 
      worker(Sloth.PlugManager, [])
    ], strategy: :one_for_one
  end
end

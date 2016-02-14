require Sloth.PlugManager

defmodule SlothSlackerTest do
  use ExUnit.Case, async: true
  import :meck
  import ExUnit.CaptureIO

  def hogehoge(send_data, captures \\ []) do
   IO.puts "hogehoge"
  end

  setup do
    {:ok, _pid} = Sloth.PlugManager.start_link
    new(GenServer, [:passthrough])
    expect(GenServer, :cast, fn(module, {:call_plugin, func, [send_data, captures]}) -> apply(module, func, [send_data, captures]) end)
    :ok
  end

  test "handle_cast no func" do
    assert {:noreply, _state} = Sloth.Slacker.handle_cast({:handle_incoming, "message", %{}}, [])
  end

  test "handle_cast one func" do
    Sloth.PlugManager.add(__MODULE__, [{~r/hogehoge/, :hogehoge}])
    send_data = %{"text" => "hogehoge"}
    assert {:noreply, _state} = Sloth.Slacker.handle_cast({:handle_incoming, "message", send_data}, [])
  end
end

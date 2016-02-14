require Sloth.PlugManager

defmodule SlothPluginTest do
  use ExUnit.Case, async: true
  import :meck
  doctest Sloth

  defmodule TestPlugin do
    use Sloth.Plugin

    plugin ~r/hogehoge/, :hogehoge

    def hogehoge do
      "hogehoge"
    end
  end

  setup do
    {:ok, _pid} = Sloth.PlugManager.start_link
    #   new Sloth.PlugManager
    #   on_exit fn -> unload end
    #   expect(Sloth.PlugManager, :add, fn(module, func) -> :ok end) 
    :ok
  end

  test "created method?" do
    assert {:ok, _pid} = TestPlugin.start_link
    assert [{regex, :hogehoge}] = Sloth.PlugManager.get(TestPlugin)
    assert Regex.regex?(regex)
  end
end

# Sloth

Sloth is Slack Bot in Elixir

use very easy.

example

```
defmodule Echo do
  use Sloth.Plugin

  plugin ~r/^echo (.*)$/, :echo

  def echo(send_data, captures \\ []) do
    Sloth.Slacker.say(send_data["channel"], List.first(captures))
  end

end
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add sloth to your list of dependencies in `mix.exs`:

        def deps do
          [{:sloth, "~> 0.0.1"}]
        end

  2. Ensure sloth is started before your application:

        def application do
          [applications: [:sloth]]
        end


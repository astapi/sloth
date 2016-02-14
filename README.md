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

[example todo app](https://github.com/tamai/sloth_example)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add sloth to your list of dependencies in `mix.exs`:

        def deps do
          [
            {:websocket_client, github: "jeremyong/websocket_client"},
            {:slacker,  "~> 0.0.1"},
            {:sloth, "~> 0.0.2"}
          ]
        end

  2. Ensure sloth is started before your application:

        def application do
          [applications: [:slacker, :sloth]]
        end

  3. add environment SLACK_TOKEN

        export SLACK_TOKEN=xxxxxxxxxxxxxxxx

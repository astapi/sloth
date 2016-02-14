defmodule Sloth.Mixfile do
  use Mix.Project

  def project do
    [app: :sloth,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [
      mod: {Sloth, []},
      applications: [:logger, :slacker]
    ]
  end

  defp deps do
    [
      {:websocket_client, github: "jeremyong/websocket_client"},
      {:slacker,  "~> 0.0.1"},
      {:meck, "~> 0.8.2", only: :test}
    ]
  end
end

use Mix.Config

config :sloth, slack_token: System.get_env("SLACK_TOKEN")
#
#     Application.get_env(:sloth, :key)

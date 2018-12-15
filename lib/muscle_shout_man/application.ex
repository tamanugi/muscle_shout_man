defmodule MuscleShoutMan.Application do

  # use Application
  import Supervisor.Spec

  def start(_type, _args) do
    token = System.get_env("SLACK_TOKEN")
    children = [
      %{
        id: Slack.Bot,
        start: {Slack.Bot, :start_link, [MuscleShoutMan, [], token]}
      }
    ]

    opts = [strategy: :one_for_one, name: ElixirSimpleHttpServer.Supervisoer]
    Supervisor.start_link(children, opts)
  end
end
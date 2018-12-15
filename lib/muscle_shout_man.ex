defmodule MuscleShoutMan do
  use Slack
  alias MuscleShoutMan.ShoutMessage

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_event(message = %{type: "reaction_added", reaction: "muscle" <> _}, slack, state) do
    %{item: %{channel: channel}, item_user: user_id} = message
    shout(user_id, slack, channel)
    {:ok, state}
  end
  def handle_event(message = %{type: "message"}, slack, state) do
    IO.inspect message
    %{text: text} = message
    if text |> String.ends_with?(":muscle:") do
      shout(message.user, slack, message.channel)
    end

    {:ok, state}
  end
  def handle_event(message, _, state) do
    IO.inspect message
    {:ok, state}
  end

  def handle_info({:message, text, channel}, slack, state) do
    IO.puts "Sending your message, captain!"

    send_message(text, channel, slack)

    {:ok, state}
  end
  def handle_info(_, _, state), do: {:ok, state}

  defp shout(user_id, slack, channel) do
    ShoutMessage.message(user_id)
    |> send_message( channel, slack)
  end
end

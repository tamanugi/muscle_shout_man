defmodule MuscleShoutMan do
  use Slack

  @shout_message ~w(
    切れてるよ
    デカい
    バリバリ
    厚みがすごい
    広い
    仕上がってる
    詰まってる
    ダントツ
    キレイ
    美しい
    カッコいい
    最強の◯◯！
    ◯番が良い！
    出ました！キマリ！
    ナイスバルク！
    ナイスポーズ
    肩メロン！
    二頭がチョモランマ
    二頭がデカい！ダチョウの卵
    三角チョコパイ
    巨乳
    大胸筋が歩いてる
    腹筋板チョコ
    腹筋グレネード
    腹筋がカニの裏
    背中に鬼の顔
    背中に羽が生えている
    背中にクリスマスツリー
    お尻にバタフライ
    脚がゴリラ
    脚がカモシカ
    ダイヤモンドカーフ[^1]
    土台が違う 土台が！
    えぐれすぎだぜー!!
    圧倒的
    アニキ、連れてってー。
    アニキー！
    大好き、結婚して♡
    彫刻みたいな身体
    阿修羅像
    プロポーションおばけ
    新時代の幕開けだ！
    侍！
    新人類
    石油王！
    肩にちっちゃいジープのせてんのかい
    HUGE!!（ヒュージ）
    NICE SHAPE!!（ナイスシェイプ）
    カブトムシひっくり返したみたいだな！
    焼き鳥
    前脚
    腹！腹にもっと力入れて！広背筋を開く！……そう！良くなった!!
    全部出せ
    笑え
    飼っている白い犬は元気？
    可愛い彼女の◯◯が見てるぞー
    パパ頑張れー
    ◯番、身体も良いが顔もいい!!
    赤が似合ってるよ
    （京大の選手に向かって）高学歴！
    筋肉本舗
    デカすぎる上腕！ひとり動物園！
    どんだけデカいの!?
    東京ドーム何個分!?
    なんだ、あのラット[^2]は！
    胸がケツみたい
    ハムケツ切れてる！
    何個あるの腹筋！
    そこまで仕上げるために眠れない夜もあっただろうに
    マッチョの満員電車だな
    来年頑張れ！
  )

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
    message = @shout_message |> Enum.random
    send_message("\\@#{user_name(user_id)} #{message}/", channel, slack)
  end

  defp user_name(user_id) do
    Slack.Web.Users.info(user_id)
    |> Map.get("user")
    |> Map.get("name")
  end
end

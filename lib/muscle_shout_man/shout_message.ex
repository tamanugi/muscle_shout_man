defmodule MuscleShoutMan.ShoutMessage do

  @messages ~w(
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
    最強の$user$:exclamation:
    $user$番が良い:exclamation:
    出ました:exclamation:キマリ:exclamation:
    ナイスバルク:exclamation:
    ナイスポーズ
    肩メロン:exclamation:
    二頭がチョモランマ
    二頭がデカい:exclamation:ダチョウの卵
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
    ダイヤモンドカーフ
    土台が違う 土台が:exclamation:
    えぐれすぎだぜー:bangbang:
    圧倒的
    アニキ、連れてってー。
    アニキー:exclamation:
    大好き、結婚して:heart:
    彫刻みたいな身体
    阿修羅像
    プロポーションおばけ
    新時代の幕開けだ:exclamation:
    侍:exclamation:
    新人類
    石油王:exclamation:
    肩にちっちゃいジープのせてんのかい
    HUGE:bangbang:
    NICE SHAPE:bangbang:
    カブトムシひっくり返したみたいだな:exclamation:
    焼き鳥
    前脚
    腹:exclamation:腹にもっと力入れて:exclamation:広背筋を開く:exclamation:……そう:exclamation:良くなった:bangbang:
    全部出せ
    笑え
    飼っている白い犬は元気:question:
    可愛い$user$の彼女が見てるぞー
    パパ頑張れー
    $user$番、身体も良いが顔もいい:bangbang:
    赤が似合ってるよ
    高学歴:exclamation:
    筋肉本舗
    デカすぎる上腕:exclamation:ひとり動物園:exclamation:
    どんだけデカいの:interrobang:
    東京ドーム何個分:interrobang:
    なんだ、あのラットは:exclamation:
    胸がケツみたい
    ハムケツ切れてる:exclamation:
    何個あるの腹筋:exclamation:
    そこまで仕上げるために眠れない夜もあっただろうに
    マッチョの満員電車だな
    来年頑張れ:exclamation:
  )

  def message(userid) do
    message = @messages
    |> Enum.random

    user_name = username(userid)
    cond do
      String.contains?(message, "$user$") -> 
        String.replace(message, "$user$", user_name)
      true -> 
        "#{user_name}、#{message}"
    end
    |> format_message
  end

  defp username(userid) do
    "<@#{userid}>"
  end
  

  defp format_message(message) do
    suffix = unless message |> String.ends_with?(":") do
      ":bangbang:"
    end
    "\\#{message}#{suffix}/"
  end
end
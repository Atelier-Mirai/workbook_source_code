##########################################################################
# 入力された英単語の長さを表示する
# （https://nzlife.net/archives/9581 に長い英単語の豆知識があります）
#
# DeepLのAPIをRubyで使ってみた
# https://zenn.dev/ingress/articles/9d29a1360e164c
# を参考に、入力した単語の意味も表示します。
#
# 【事前準備】
# gemのインストールが必要です。ターミナルより以下を入力してください。
# gem install deepl-rb
##########################################################################

# deepLライブラリを読み込みます。
require "deepl"

# DeepL による翻訳メソッド
def deepl_translation(sentence)
  DeepL.configure do |config|
    # config.auth_key = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:xx"
    config.auth_key = "151b4337-b769-8795-1495-917107090691:fx"
    config.host     = "https://api-free.deepl.com"
  end

  # 日本語へ翻訳
  translation = DeepL.translate sentence, nil, "ja"

  # 翻訳後のテキストを返す
  return translation.text

rescue DeepL::Exceptions::RequestError => e
  puts "おっと!! エラーが発生しました。"
  puts "Code: #{e.response.code}"
  puts "Response body: #{e.response.body}"
  puts "Request body: #{e.request.body}"
end

loop do
  # 入力を促すメッセージの表示
  puts "英単語を入力して下さい。終了:bye"

  # キーボードから一行読み込む
  word = gets.chomp

  if word == "bye"
    puts "また、使ってね。bye-bye"
    break # 中断してループから抜ける
  else
    # 行指向文字列リテラル（ヒアドキュメント）を用いると、
    # 長い文章も円滑に記述できます。
    puts <<~EOS
      入力された英単語は、#{word} ですね。"
      長さは、#{word.length} 文字の単語ですね。"
      意味は、#{deepl_translation(word)} ですね。"

    EOS
  end
end

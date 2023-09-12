puts "今何時ですか？"     # 入力を促すために、メッセージを表示
hour = gets.chomp.to_i    # hour は 今何時か、格納する為の変数
                          # getsメソッドでキー入力を読み込み、
                          # chompメソッドで末尾の改行文字を取り除き、
                          # to_i メソッドで、文字列から整数型に変換する

# 時刻に応じた挨拶をする
if hour < 12              # 午前中
  puts "おはようございます"
elsif hour < 18        # 夕方まで
  puts "こんにちは"
else                     # 夜なら
  puts "おやすみなさい"
end

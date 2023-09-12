# 実行した時刻等によって、異なった乱数となるように乱数の種を播きます。
# (いつも同じ乱数にしたければ、srand 123 の様に数を指定します)
srand

# 1, 2, 3, 4, 5, 6 の乱数を生成し、dice に代入します。
dice = rand(1..6)

# #{dice} は「式展開」と呼ばれる書き方です。
# 実際の dice の値に展開されて、出力されます。
puts "サイコロの目は #{dice} です。"

# ２で割った余りが０なら、偶数、そうでないなら奇数です。
if dice % 2 == 0
  puts "偶数です"
else
  puts "奇数です"
end

# 論理和を使って、このように書くことも出来ます。
if dice == 2 || dice == 4 || dice == 6
  puts "偶数です"
else
  puts "奇数です"
end

# case 式を使って書くことも出来ます。
case dice
when 1, 3, 5
  puts "奇数です"
else
  puts "偶数です"
end

# 奇偶を判定する odd? even? メソッドを使うことも出来ます。
if dice.odd?
  puts "奇数です"
else
  puts "偶数です"
end

# 三項演算子を使って一行で書くことも出来ます。
puts dice.odd? ? "奇数です" : "偶数です"

# 入力処理
puts "身長(cm)を入力して下さい。"
# 身長
height = gets.chomp # getsメソッドでキー入力を受け取ります。
                    # chompメソッドで改行文字を取り除きます。

puts "体重(kg)を入力して下さい。"
# 体重
weight = gets.chomp

# BMI算出
# String(文字列)クラスのheightを、to_fメソッドを使って
# Float(浮動小数点数)クラスに変換しています。
# ** は 冪乗(べきじょう)演算子です。
bmi = weight.to_f / (height.to_f / 100) ** 2

# 結果表示
printf "BMI は %4.2f です。\n", bmi
if bmi < 18.5
  puts "痩せすぎです。"
elsif bmi < 25
  puts "標準です。"
else
  puts "肥満です。"
end

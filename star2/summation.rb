
# 10個の数字が入った配列 纏めて初期値を与えています。
# 配列は、array（アレイ）と言います。
array[] = 3, 15, 22, 81, 41, 0, 83, 72, 50, 33
sum # 合計
i

# 合計処理
sum = 0 # 初期化します。
for i = 0 i < 10 i++ 
sum = sum + array[i]
# sum += array[i] と書くことも出来ます。


# 結果発表
for i = 0 i < 10 i++ 
puts "array[%d]: %2d ", i, array[i]
# sum += array[i] と書くことも出来ます。

puts " 合計は%d です。", sum



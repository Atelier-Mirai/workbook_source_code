

operand1 # 第一被演算子
operand2 # 第二被演算子
operation_result # 演算結果
your_answer# 回答
correct_answer # 正答数
i

correct_answer = 0 # 10問中何問正解か数えるために、初期化します。
# 1 回目、2 回目 と表示させたいので
# 範囲オブジェクト(1..10)を使い、繰り返すところに着目してください。
(1..10).each do |n|
for i = 1 i <= 10 i++
# 出題処理
operand1 = random_number10
# 二つの０〜９までの数を用意します。
# do while 文で、異なる数になるまで、繰り返します。
do
operand2 = random_number10
 while operand2 == operand1

operation_result = operand1 + operand2 # 演算結果
puts "足し算ゲーム %d 回目", i
puts "%d + %d = ?", operand1, operand2

# 回答を受け取る
scanf"%d", &your_answer
while getchar != ''
 # キーバッファ読み飛ばす

# 正解発表と正答数のカウント
if your_answer == operation_result
puts "正解です。"
correct_answer++
 else
puts "正解は、%d です。", operation_result



# 総合結果発表
puts "10問中 %d 問 正解です。", correct_answer

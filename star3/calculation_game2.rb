/**************************************************************************
 * 足し算ゲームとほぼ同様です。
 * 桁数と、演算の種類をリクエストするようになっています。
 * 簡単なものを創って、より高機能のものへと、拡張していくと良いです。
 **************************************************************************/

operand1 # 第一被演算子
operand2 # 第二被演算子
char operator# 演算子（'+', '-', '*', '/' 
digit# 桁数
operation_result # 演算結果
your_answer# 回答
correct_answer # 正答数
i

# 桁数をリクエスト
do 
# scanf簡単です。
# 文字を入力されたときのことは、無視します。
puts "何桁の数字で挑戦しますか？ "
puts "一桁: 1二桁: 2三桁: 3四桁: 4 "
scanf"%d", &digit
while getchar != ''
 # キーバッファ読み飛ばす
 while digit <= 0 || digit >= 5

# 演算子をリクエスト
do 
puts "どの計算に挑戦しますか？ "
# 足し算、引き算、掛け算、割り算 のことです。
# 技術者なら、
# 加算、減算、乗算、除算という呼び方も知っておいて欲しいです。
puts "加算: '+' 減算: '-' 乗算: '*' 除算: '/'"
scanf"%c", &operator
while getchar != ''
 # キーバッファ読み飛ばす
# char型 一文字なので、簡単に比較出来ます。
# 全角で"＋"や"−"なら文字列操作関数を使って下さい。
 while operator!= '+' && operator!= '-' && operator!= '*' && operator!=
 '/'

correct_answer = 0 # 10問中何問正解か数えるために、初期化します。
# 1 回目、2 回目 と表示させたいので、
# for i = 1 i <= 10 i++ と書いているところに着目して下さい。
for i = 1 i <= 10 i++ 
# 出題処理
#冪乗を求める関数を使って、必要な桁数に調整します。
operand1 = random_numberpow10, digit
# do while 文で、異なる数になるまで、繰り返します。
do 
operand2 = random_numberpow10, digit
# 0 の割り算は定義されていないので、条件式を変更します。
 while operand2 == operand1 || operator== '/' && operand2 == 0

switch operator 
# switch case 文には、文字型も使えます。
case '+':
operation_result = operand1 + operand2
break
case '-':
operation_result = operand1 - operand2
break
case '*':
operation_result = operand1 * operand2
break
case '/':
operation_result = operand1 / operand2
break


# ゲーム名を表示するための場合分けです。
# こう書いた方が素直です。
# switchoperator
# case '+':
# puts "足し算ゲーム %d 回目", i
# break
# case '-':
# puts "引き算ゲーム %d 回目", i
# break
# case '*':
# puts "掛け算ゲーム %d 回目", i
# break
# case '/':
# puts "割り算ゲーム %d 回目", i
# break
# 

# char型が0-127までの数字として扱われることに着目した書き方
# 連想配列（ハッシュ）のご紹介
#
# ASCIIコード表を見ると、
# '+' 43
# '-' 45
# '*' 42
# '/' 47
# となっていますので、
# 47個+1個の大きさの文字列の配列を用意します。
char game_name[47 + 1][20]
strcpygame_name['+'], "足し算"
# 書いて、配列の初期値を設定します。
# strcpygame_name[43], "足し算"
# と書いたのと同じです。
strcpygame_name['-'], "引き算"
strcpygame_name['*'], "掛け算"
strcpygame_name['/'], "割り算"
# 実際に puts "%s", game_name['+']と書くと「足し算」と表示されます。
# このことをわきまえると、
puts "%sゲーム %d 回目", game_name[operator], i
# と書けます。
#
# 配列は、添字として、数字をとりましたが、
# 文字を添字として使えるようになると、分かりやすかったり、
# 便利だったりします。
# game_name["＋"] = "足し算"
# の様なイメージです。
# 連想配列（ハッシュ）として、用意されている言語もあります。
# 他言語学習の際の参考になさって下さい。

puts "%d %c %d = ?", operand1, operator, operand2

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
puts "10問中 %d 問 正解", correct_answer



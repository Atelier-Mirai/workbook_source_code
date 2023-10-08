##########################################################################
# Ruby の乱数は、
# 数学者の松本眞さんとと西村拓士さんによって考案された
# メルセンヌツイスタ（Mersenne Twister）法を用いています。
# ゲームらしく、10題解くのにかかった時間も表示しています。
##########################################################################

# 実行した時刻等によって、異なった乱数となるように乱数の種を播きます。
# (いつも同じ乱数にしたければ、srand 123 の様に数を指定します)
srand

# 初期化
# 繰り返し内で出現した変数は、その繰り返しの中でのみ有効となります。
# 有効範囲（スコープ）と言います。
# 繰り返しの外で出現させることにより、どの繰り返しの中でも
# これらの変数が使えるようになります。
operand1    = 0   # 第一被演算子
operand2    = 0   # 第二被演算子
operator    = "+" # 演算子（"+", "-", "*", "/")
digit       = 1   # 桁数
result      = 0   # 演算結果
answer      = 0   # 回答
correct     = 0   # 正答数
start_time  = 0   # ゲーム開始時刻
finish_time = 0   # ゲーム完了時刻

# オープニング
puts "****************************************************"
puts "*"
puts "*　　　　　　　計算ゲームへようこそ"
puts "*"
puts "****************************************************"
puts ""

# 桁数をリクエスト
loop do
  puts "何桁の数字で挑戦しますか？ "
  puts "一桁: 1　二桁: 2　三桁: 3　四桁: 4"
  digit = gets.chomp.to_i


  if digit.between?(1, 4)
    break
  end
end

# 演算子をリクエスト
loop do
  puts "どの演算に挑戦しますか？ "
  puts "加算: +　減算: -　乗算: *　除算: /"
  operator = gets.chomp
  # 後置if文です。
  # 処理が一行のみの場合、簡潔に書くことが出来ます。
  break if ["+", "-", "*", "/"].include? operator
end

# 出題処理
correct = 0 # 正答数初期化
start_time = Time.now # ゲーム開始時刻を取得
(1..10).each do |n|
  # 第一被演算子と第二被演算子を用意
  operand1 = rand(0...10**digit)
  operand2 = (operator == "/" ? rand(1...10**digit) : rand(1...10**digit))
  loop do
    if operand2 == operand1
      operand2 = (operator == "/" ? rand(1...10**digit) : rand(1...10**digit))
    else
      break
    end
  end

  # 正答を用意
  result =  case operator
            when "+"
              operand1 + operand2
            when "-"
              operand1 - operand2
            when "*"
              operand1 * operand2
            when "/"
              operand1 / operand2
            end

  # 何回目のゲームか表示
  game_name = { "+": "足し算", "-": "引き算", "*": "掛け算", "/": "割り算" }
  printf "%sゲーム %d 回目\n", game_name[operator.to_sym], n

  # 出題する
  printf "%d %c %d = ?\n", operand1, operator, operand2

  # 回答を受け取る
  answer = gets.chomp.to_i

  # 正解発表と正答数のカウント
  if answer == result
    puts "正解です。"
    correct += 1           # Ruby にはインクリメント演算子はありません。
                           # 自己代入演算子で代用します。
  else
    puts "正解は、#{result} です。"
  end
end

# ゲーム完了時刻の保存
finish_time = Time.now

# 総合結果発表
puts "****************************************************"
puts "* "
puts "*　　　　　　　　 結　果　発　表"
puts "* "
puts "*　　　　　　10問中 #{correct} 問 正解"
puts "*　　　　　　#{finish_time - start_time} 秒 でクリア！"
puts "* "
puts "*　　　　　　おめでとうございます！ "
puts "* "
puts "****************************************************"
puts ""

# 1 + 1 などが出現せぬよう、
# 被演算子が重複しないようにしましたが、
# 重複を許可する、
# 引き算の結果は正の範囲に納める、
# 剰余演算を追加するなど、
# いろいろ発展させていって下さい。

# 実行した時刻等によって、異なった乱数となるように乱数の種を播きます。
# (いつも同じ乱数にしたければ、srand 123 の様に数を指定します)
srand

correct = 0 # correct は 10問中何問正解か数える為の変数です。
            # まず 0 に初期化します。

# 1 回目、2 回目 と表示させたいので
# 範囲オブジェクト(1..10)を使い、繰り返すところに着目してください。
(1..10).each do |n|
  # 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 の乱数を生成し、
  # 第一被演算子 operand1 に代入します。
  operand1 = rand(0..9)

  # 第二被演算子 operand2 が
  # 第一被演算子 operand1 と
  # 異なる数になるまで、繰り返します。
  operand2 = rand(0..9)
  loop do
    if operand2 == operand1
      operand2 = rand(0..9)
    else
      break
    end
  end

  result = operand1 + operand2 # 演算結果

  # #{n} は「式展開」と呼ばれる書き方です。
  # 実際の n の値に展開されて、出力されます。
  puts "足し算ゲーム #{n} 回目"
  puts "#{operand1} + #{operand2} = ?"

  # 回答を受け取ります
  answer = gets.chomp.to_i  # answer は 入力された値を格納する為の変数です。
                            # getsメソッドでキー入力を読み込みます。
                            # chompメソッドで末尾の改行文字を取り除きます。
                            # to_i メソッドで、文字列から整数型に変換します。

  # 正解発表と正答数のカウント
  if answer == result
    puts "正解です。"
    # Ruby には インクリメント演算子 ++ はありません。
    # 自己代入演算子 += 1 を用い 正答数を一つ増やします。
    correct += 1
  else
    puts "正解は #{result} です。"
  end
end


# 総合結果発表
puts "10問中 #{correct}問 正解です。"

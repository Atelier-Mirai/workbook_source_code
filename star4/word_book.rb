##########################################################################
# 英単語帳アプリを創ってみましょう。
# I -> わたし
# love -> 愛する
# you -> あなた
# と答えられたら、満点です。
# 10問出題して、英語力向上を目指しましょう。
##########################################################################

# 実行した時刻等によって、異なった乱数となるように乱数の種を播きます。
# (いつも同じ乱数にしたければ、srand 123 の様に数を指定します)
srand

# 定数宣言
CHOICES_SIZE   =  3 # 三択で出題する
REGISTERD_WORD = 10 # 登録単語数

# 出題用配列
english_words  = ["", "I", "love","you",
                  "C","language","lesson","happy",
                  "hacker", "programming", "computer"]
japanese_words = ["", "わたし", "愛する","あなた",
                  "C","言語", "学習","幸せ",
                  "技術者", "プログラミング", "コンピュータ"]

# オープニング
puts "****************************************************"
puts "* "
puts "*              英単語ゲームへようこそ"
puts "* "
puts "****************************************************"
puts ""

# 出題処理

# 10題出題する
score = 0
(1..10).each do |question_number|
  puts "【第 #{question_number} 問】"

  # 選択肢 choices[1], [2], [3] に単語番号(添字)をセット
  # 範囲オブジェクト(1..10)に、to_a メソッドを呼び出すと、
  # 配列[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]が得られます。
  # shuffle メソッドは、その名の通り配列の要素をランダムにシャッフルします。
  # [0..2]で、シャッフルされた配列の先頭要素三つを取得出来ます。
  choices = (1..REGISTERD_WORD).to_a.shuffle[0..2]

  # choice[0], [1], [2] の中から、いずれかを正解として設定する
  # shuffle メソッドは、配列要素を一つからランダムに選んで返します。
  correct = (0...CHOICES_SIZE).to_a.sample

  # correct を正解として設定したので、
  # choices[correct] の単語を出題する
  printf "%s\n", english_words[choices[correct]]

  # 選択肢を提示する
  # (choices[correct] の単語が必ず選択肢に含まれている)
  (0...CHOICES_SIZE).each do |i|
    printf "%d: %s ", i+1, japanese_words[choices[i]]
  end
  printf "\n"

  # 1 ~ 3 までの入力を求める
  answer = gets.chomp.to_i
  loop do
    break if answer.between?(1, CHOICES_SIZE) # 1 ~ 3 の範囲内にあるなら
  end

  # 正解判定
  if answer-1 == correct
    printf "正解です！\n\n"
    score += 1 # 得点加算
  else
    printf "残念。正解は、%d: %s です。\n\n",
        correct+1, japanese_words[choices[correct]]
  end
end

# 総合結果発表
puts "****************************************************"
puts "* "
puts "*                 結　果　発　表"
puts "* "
puts "*               10 問中 #{score} 問 正解"
puts "* "
puts "*             おめでとうございます！ "
puts "* "
puts "****************************************************"
puts ""

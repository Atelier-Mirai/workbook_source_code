/**************************************************************************
 * 英単語帳アプリを創ってみましょう。
 * I -> わたし
 * love -> 愛する
 * you -> あなた
 * と答えられたら、満点です。
 * 10問出題して、英語力向上を目指しましょう。
 **************************************************************************/



# 出題用配列
char *english_words[] = "", "I", "love","you",
 "C","language","lesson","happy",
 "hacker", "programming", "computer"
char *japanese_words[] = "", "わたし", "愛する","あなた",
"C","言語", "学習","幸せ",
"技術者", "プログラミング", "コンピュータ"

# 三択で出題する
choices[CHOICES_SIZE + 1] # 0 は未使用とするため、+1
candidate # 選択肢の候補
registerd_word = 10 # 登録単語数
question_number # 第何問目か？
correct_answer# 正答
your_answer # 入力された回答
score # 得点
flag
i

# オープニング
puts "****************************************************"
puts "* "
puts "* 英単語ゲームへようこそ"
puts "* "
puts "****************************************************"
puts ""

# 出題処理

# 10題出題する
score = 0
for question_number = 1 question_number <= 10 question_number++ 
puts "【第 %d 問】", question_number

# 選択肢の初期化
for i = 0 i <= CHOICES_SIZE i++ 
choices[i] = 0


# choices[1], [2], [3] に出題番号をセット
do 
# 1から3の乱数を取得
candidate = genrand_int32 % registerd_word + 1
# 選択肢に登録済みか調べる。
flag = FALSE
for i = 1 i <= CHOICES_SIZE i++ 
if candidate == choices[i] 
flag = TRUE # すでに選ばれていた
break


# 選択肢には未登録であったので、登録する
if flag == FALSE 
for i = 1 i <= CHOICES_SIZE i++ 
if choices[i] == 0 
# i番目の選択肢として登録する
choices[i] = candidate
break



# choice[3]（最後の選択肢）に0以外の値がセットされるまで繰り返す
 while choices[CHOICES_SIZE] == 0

# choice[1], [2], [3] の中から、いずれかを正解として設定する
correct_answer = genrand_int32 % 3 + 1

# 出題する
puts "%s", english_words[choices[correct_answer]]

# 選択肢を提示する
for i = 1 i <= CHOICES_SIZE i++ 
puts "%d: %s ", i, japanese_words[choices[i]]

puts ""

# 1-3 までの入力を求める
do 
scanf"%d", &your_answer
while getchar != ''
 # キーバッファ読み飛ばす
 while your_answer <= 0 || your_answer > CHOICES_SIZE

# 正解判定
if your_answer == correct_answer 
puts "正解です！"
score++ # 得点加算
 else 
puts "残念。正解は、%d: %s です。", correct_answer,
 japanese_words[choices[correct_answer]]



# 総合結果発表
puts "****************************************************"
puts "* "
puts "* 結　果　発　表"
puts "* "
puts "* 10 問中 %d 問 正解", score
puts "* "
puts "*おめでとうございます！ "
puts "* "
puts "****************************************************"
puts ""



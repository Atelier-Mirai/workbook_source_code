puts "=== 野菜を一日３５０ｇ食べましょう ==="

total =   0 # 今まで食べた量の合計
goal  = 350 # 目標

(1..3).each do |n|
  case n
  when 1
    printf "朝ごはん"
  when 2
    printf "昼ごはん"
  when 3
    printf "夜ごはん"
  end
  puts "では、何ｇ食べましたか？"

  # キーボードから入力された食べた野菜の量を取得します。
  vegetable = gets.chomp.to_i

  # 合計を取る
  # total += vegitable と自己代入演算子を使って書くこともできます。
  total = total + vegetable
  # 整数同士の割り算は切り捨てられるため、
  # 100を先に掛けることで、答が0や1になることを防ぎます。
  ratio = 100 * total / goal
  # 書式指定子にも % を使うため、
  # printf の中で、% を表示するためには、%% を記述します。
  printf "達成率は %d %%です\n", ratio
  if n <= 2 && total < goal
    printf "残り %d ｇの野菜を食べましょう\n\n", goal - total
  else
    printf "\n"
    break
  end
end

# 結果発表
# #{total} は「式展開」と呼ばれる記法です。
# total の値が、文字列中に埋め込まれ、出力されます。
puts  "今日は #{total} ｇの野菜を摂りました。"
if total >= goal
  puts "健康な食生活です*^_^*"
else
  puts "もう少し野菜を食べましょう*^_^*"
end

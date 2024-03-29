##########################################################################
# １０人の名前が格納された配列と、１０人の点数が格納された配列があります。
# 成績の良い順に名前と点数を表示してみましょう。
#
# Rubyには 配列の並び替えを行う為の sort メソッドが用意されていますので、
# 今回はこれを用います。
#
# sortメソッド
# https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/sort.html
##########################################################################

# 変数宣言
names  = ["亜希", "加世", "小夜", "多実", "奈美",
          "太郎", "次郎", "三郎", "四郎", "五郎"]
scores = [55, 88, 77, 66, 55,
          55, 64, 73, 82, 91]

# 結果表示
puts "並び替え前"
names.each_with_index do |name, index|
  puts "#{name} #{scores[index]}"
end

# 点数から名前を引けるよう、並び替え前の点数のバックアップを取ります。
backup = scores.dup

# 並び替えを行う
# sort メソッドで並び替えます。
# scores.sort で昇順に並びますが、ここでは降順に並び替えたいです。
# 降順で並び替えるには、sortメソッドにブロックを指定します。
scores = scores.sort { |a, b| b <=> a }

puts "並び替え後"
# 並び替え結果に基づいて、名前を表示する
scores.each_with_index do |score, index|
  # 例 index = 0 のとき score には 91 点が入っている
  # 名前も連動して並び替えられると良いが、
  # そういう作りにはしていないので、
  # backup配列を参照して、
  # 91 点の人は何番目であったか、検索する
  # indexメソッドを使うと、scoreに一致する要素の添字を取得できます。
  j = backup.index(score)
  # 同じ点数（亜希、奈美、太郎）の場合、
  # 既に選択済みであることを示す為、
  # あり得ない点数の -1 を設定する。
  # （「番兵」と呼ばれるテクニックです。）
  backup[j] = -1

  printf "%s %d\n", names[j], score
end

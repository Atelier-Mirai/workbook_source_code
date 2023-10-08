# Ruby は より大きな整数値を扱えますが、
# C言語に倣って、int型32ビットで表せる最大値 2^31 -1 を定数宣言しました。
# 大きな数が読みやすいように
# 適宜「_(アンダースコア)」を入れることが出来ます。
INT_MAX = 21_4748_3647

# 10個の数字が入った並び替え前の配列
array = [3, 15, 22, 81, 41, 83, 72, 0, 50, 33]


# (a) 最小値を求める処理
min = INT_MAX  # 最小値を格納する変数
array.each do |member|
  if min > member
    min = member
  end
end

# (b) min は 配列の最小値 0 となっています。
# 最小値0 が array の何番目の要素であったかを求めてみましょう。
index = 0 # 最小値 min が何番目の要素であるか
(0...10).each do |i|
  if array[i] == min
    index = i
    break
  end
end

puts "(a)(b)それぞれ行った場合の結果表示"
(0...10).each do |i|
  printf "array[%d]: %2d\n", i, array[i]
end
printf "min: %d index: %d\n", min, index

# ここで、(a) と (b) 同時に出来るのではと思えて来ます。
# Ruby には 要素とその添字を取得できる
# each_with_index メソッドが用意されています。
# 一緒に書くと、次のようになります。
# 最小値を求めると同時に、最小値 min が何番目の要素であるか求める
min   = INT_MAX
index = 0
array.each_with_index do |member, i|
  if min > array[i]
    min   = array[i] # (a)
    index = i        # (b)
  end
end

puts "(a)(b)纏めて行った場合の結果表示"
(0...10).each do |i|
  printf "array[%d]: %2d\n", i, array[i]
end
printf "min: %d index: %d\n", min, index

# index には、7番目と入っています。
# 後ろの要素を前の要素に詰めます。
# array[7] に array[8] を代入して、
# array[8] に array[9] を代入します。
(index...9).each do |i|
  array[i] = array[i + 1]
end

# 前回は、array[9] は特に処理せず、そのままでしたが、
# 今回は、array[9] に、今求めた、一番小さい数を入れます。
array[9] = min

# 一番小さい数が、array の最後に来ているはずです。
# 確認の為に出力してみましょう。
puts "一番小さい数が、最後に来ていることの確認"
(0...10).each do |i|
  printf "array[%d]: %2d\n", i, array[i]
end

# これで、一番小さい数を、最後に持って行くことが出来ました。
# 次は、０番目〜８番目で並び替え、
# その次は、０番目〜７番目で並び替え、
# ということを順番に繰り返していくと、全部の並び替えが完了します。

# 完成版のプログラムです。
# ０番目〜何番目までを並び替えるのか、
# 管理するためのfor文で外側をくるんでいます。
# この並び替えのアルゴリズムを、選択ソート と言います。

# Ruby には
# 1ずつ増やしながら繰り返し実行する為のメソッドとして upto が、
# 1ずつ減らしながらら繰り返し実行する為のメソッドとして downto が、
# 用意されています。
9.downto(1) do |sorted| # 今、何番目の要素まで並び替えが終了しているのか。
  min = INT_MAX
  0.upto(sorted) do |i|
    if min > array[i]
      min   = array[i] # (a)
      index = i        # (b)
    end
  end
  (index...sorted).each do |i|
    array[i] = array[i + 1]
  end
  array[sorted] = min
end

puts ""
puts "【選択ソート】並び替え結果"
(0...10).each do |i|
  printf "array[%d]: %2d\n", i, array[i]
end

# Ruby には、ヒアドキュメント（行指向文字列リテラル）が用意されています。
# これを用いると長い文字列の取り扱いが楽です。
puts <<~EOS

  選択ソートの他に、有名な並び替え方法としては、
  シェルソート
  クイックソート
  マージソート
  などがあります。
  どうぞ学習なさって下さい。
EOS

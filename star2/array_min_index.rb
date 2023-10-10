# Ruby は より大きな整数値を扱えますが、
# C言語に倣って、int型32ビットで表せる最大値 2^31 -1 を定数宣言しました。
# 大きな数が読みやすいように
# 適宜「_(アンダースコア)」を入れることが出来ます。
INT_MAX = 21_4748_3647

# 10個の数字が入った並び替え前の配列
array = [3, 15, 22, 81, 41, 83, 72, 0, 50, 33]

# (a) 最小値を求める処理
min = INT_MAX  # 最小値を格納する変数
# eachメソッドを使うと、
# 配列の要素を順に取り出すこととができます。
array.each do |member|
  # もし、配列の要素が、
  # これまでに判明している最小値よりも、小さかったなら、
  # 新しい最小値が発見されたことになるので、
  # 最小値を更新します。
  if min > member
    min = member
  end
end



# (b) min は 配列の最小値 0 となっています。
# 最小値0 が array の何番目の要素であったかを求めてみましょう。
index = 0 # 最小値 min が何番目の要素であるか
(0...10).each do |i|
# 配列の要素と最小値が一致するか、順に比較していきます。
  if array[i] == min
    # もし一致する要素が見つかったならば、
    # 添字を取得して、繰り返しを抜けます。
    index = i
    break
  end
end

# 結果表示
(0...10).each do |i|
  printf "array[%d]: %2d\n", i, array[i]
end
printf "最小値: %d 添字: %d\n", min, index

# ここで、(a) の最小値を求める処理と、
# (b) の添字を求める処理が一緒に出来るのではと思えて来ます。
# Ruby には 要素とその添字を取得できる
# each_with_index メソッドが用意されています。
# 一緒に書くと、次のようになります。

# 最小値を求めると同時に、
# 最小値 min が何番目の要素であるか求める処理
min   = INT_MAX
index = 0
array.each_with_index do |member, i|
  if min > array[i]
    min   = array[i] # (a) 最小値を求める
    index = i        # (b) 添字を求める
  end
end

# 結果表示
# もちろん同じ結果になります。
(0...10).each do |i|
  printf "array[%d]: %2d\n", i, array[i]
end
printf "最小値: %d 添字: %d\n", min, index

# 10個の数字が入った配列
# [] 内に記述することで、配列要素をを与えられます。
# 配列は arrayアレイ と言います。
array = [3, 14, 15, 92, 65, 35, 89, 79, 24, 58]

# 合計処理
sum = 0 # 初期化します。
# Ruby では、for 文よりは、
# 範囲オブジェクトとeachメソッドの組み合わせ等が良く用いられます。
# (0...10).each で、変数iには、
# 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 が順に入ります。(10は含まない)
(0...10).each do |i|
  sum = sum + array[i]
  # sum += array[i] と書くことも出来ます。
end

# 結果発表
# 結果を出力します。
(1..9).each do |i|
  puts "%2d + ", array[i]
end
puts "%2d = %3d です。\n", array[9], sum

# Ruby には配列の為の様々なメソッドが備わっています。
# eachメソッドにより、配列の要素を一つ一つ取り出すことが出来ます。
sum = 0
array.each do |member|
  sum = sum + member
end
puts " 合計は #{sum} です。"

# do ~ end は { } を使って、一行で書くことも出来ます。
sum = 0
array.each { |member | sum = sum + member }
puts " 合計は #{sum} です。"

# 少し初心者向けではありませんが、
# 畳み込み演算を行うinjectメソッドを使って書くことも出来ます。
# inject(0) は sum に sum = 0 と初期値を与える意味です。
array.inject(0) { |sum, member| sum + member }
puts " 合計は #{sum} です。"
# array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] とすると、
# array.inject(0) { |sum, member| sum + 1.0 / member }
# で自然数の逆数の和を求めることも出来ます。
# 参考: https://www.chart.co.jp/subject/sugaku/suken_tsushin/89/89-7.pdf

# injectメソッドで単純に加算するだけであれば、より簡潔に次のように書けます。
array.inject(:+)
puts " 合計は #{sum} です。"

# sum メソッドを使って、合計を求めるのが最も簡単でしょう。
puts " 合計は #{array.sum} です。"

# 様々な書き方が出来ますので、適宜、習得なさってください。

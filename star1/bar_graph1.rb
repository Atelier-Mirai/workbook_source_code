# 横棒グラフを表示します。
# 直接、表示することも出来ます。
puts "■■■■■"
puts "■■■■□"
puts "■■■□□"
puts "■■□□□"
puts "■□□□□"

# Ruby では、for 文よりは、
# 範囲オブジェクトとeachメソッドの組み合わせ等が良く用いられます。
# (0...5).each で、行の変数rowには、0, 1, 2, 3, 4 が順に入ります。(5は含まない)
# (0..5).each  で、行の変数rowには、0, 1, 2, 3, 4, 5 が順に入ります。(5を含む)
(0...5).each do |row|
  black_number = 5 - row # 黒い■の数
  white_number = row     # 白い□の数

  # Rubyは文字列操作にも柔軟性があります。
  # 例えば "■" * 3 で "■■■" になります。
  # 文字列を連結する際には、「+」演算子を用いることも出来ます。
  print "■" * black_number + "□" * white_number + "\n"
end

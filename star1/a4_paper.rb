height = 29.7           # Ruby では型宣言不要です。
width  = 21.0
area   = height * width # 掛け算は「×」の代わりに「*」を使います。
puts area               # puts メソッドで 結果を出力できます。

# 誤差が気になる場合には、有理数型(rational number)として計算出来ます。
height = 29.7r          # 最後に「r」を付けます。
width  = 21.0r
area   = height * width
puts area

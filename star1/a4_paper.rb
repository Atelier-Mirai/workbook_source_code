# 変数宣言
height = 29.7           # Ruby では型宣言不要です。
width  = 21.0

# 面積を計算する
area   = height * width # 掛け算は「×」の代わりに「*」を使います。

# 結果を表示する
puts area               # puts メソッドで 結果を出力できます。

printf "%f\n", area     # 小数を表示する際の書式指定子には %f を使います。
                        # '\n' は「改行文字」です。
                        # 文末で改行したいときに入れます。
printf "%8.3f\n", area  # 8.3f は 全体で8桁、小数点以下3桁で表示します。
printf "%08.3f\n", area # 08.3f とすると、先頭に0埋めして表示します。

# 誤差が気になる場合には、有理数型 rational number)として計算出来ます。
height = 29.7r          # 最後に「r」を付けます。
width  = 21.0r
area   = height * width
# 結果を表示する
puts area
# 書式を指定すると、適宜変換して表示されます。
printf "%8.3f\n", area

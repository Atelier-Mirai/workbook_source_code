# 消費税率
# 変数にしておくと、変更があった場合の修正が楽です。
TAX_RATE = 0.08

# 消費税を求めます。
icecream = 98               # アイスクリームの値段
price    = icecream * 3     # お買い上げ額
tax      = price * TAX_RATE # 消費税額
total    = price + tax      # 合計額

# Ruby も もちろん printf 文が使えます。
# %-5d で左詰で5桁表示されます。
printf "お買い上げ額は、　　%-5d  円です。\n", price
printf "消費税は、　　　　　%6.2f 円です。\n", tax
printf "合計額は、　　　　　%6.2f 円です。\n", total
# 切り捨て floorは床の意味です。
printf "端数を切り捨てると、%6.2f 円です。\n", tax.floor
# 切り上げ ceilは天井の意味です。
printf "端数を切り上げると、%6.2f 円です。\n", tax.ceil

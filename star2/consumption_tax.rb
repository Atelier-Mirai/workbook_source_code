

# 消費税を求めます。
icecream = 98 # アイスクリームの値段
# 消費税率
# 変数にしておくと、変更があった場合の修正が楽です。
consumption_tax_rate = 0.08
consumption_tax # 消費税額

consumption_tax = icecream * 3 * consumption_tax_rate
# %-5d で左詰で5桁表示されます。
puts "お買い上げ額は、　　%-5d円です。", icecream * 3
puts "消費税は、　　　　　%6.2f 円です。", consumption_tax
# 切り捨て floorは床の意味です。
puts "端数を切り捨てると、%6.2f 円です。", floorconsumption_tax
# 切り上げ ceilは天井の意味です。
puts "端数を切り上げると、%6.2f 円です。", ceilconsumption_tax



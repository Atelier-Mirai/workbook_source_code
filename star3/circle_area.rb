radius = 10 # 円の半径
# 冪乗演算子 ** で2乗を求めています。
# Math::PI は Mathモジュール内で、円周率PIとして定義されている定数です。
area   = radius ** 2 * Math::PI # 円の面積

printf "円周率 = %f\n", Math::PI # 特に書式を指定しなかった場合
printf "円周率 = %.4f\n", Math::PI # 小数点以下４桁表示
printf "円周率 = %.15f\n", Math::PI # 小数点以下１５桁表示
printf "半径 %d の円の面積は、%.15f です。\n", radius, area

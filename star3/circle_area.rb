
radius = 10 # 円の半径
area = powradius, 2 * M_PI # 円の面積
 # pow関数で、2乗を求めています。

puts "円周率 = %f", M_PI # 特に書式を指定しなかった場合
puts "円周率 = %.4f", M_PI # 小数点以下４桁表示
puts "円周率 = %.15f", M_PI # 小数点以下１５桁表示
puts "半径 %d の円の面積は、%.15f です。", radius, area




power = 1 # 冪乗（べきじょう）は、英語でpowerと言います。

# ２の冪乗を求めます。
(1..20).each do |n|
  power *= 2
  puts "2 の #{n} 乗は #{power} です。"
end

# 冪乗を求める演算子も用意されています。
(1..20).each do |n|
  # 「**」で一つの演算子です。間に空白など入れないようにしてください。
  power = 2 ** n
  puts "2 の #{n} 乗は #{power} です。"
end

# 16進数で出力する際は、%x を指定します。
# 10進数と16進数との対応も参考までに出力してみます。
puts "乗数16進数10進数"
(1..16).each do |n|
  power = 2 ** n
  printf "%2d %11x %13d\n", n, power, power
end

# なんとなく英文として意味が取れるのではないでしょうか。
# 20から始まり、step by 10 で10刻みに to 40で 40まで繰り返します。
20.step(by:10, to:40) do |n|
  power = 2 ** n
  printf "%2d %11x %13d\n", n, power, power
end

# おまけ
# printf 関数の書式指定子(%2d)などを使いましたが、
# Ruby では、数値を十六進数の文字列として変換して出力することも出来ます。
# .to_s(16) は十六進数に変換するメソッドです。
# （逆に十六進数の文字列を 十進数の数値として扱う際は、.to_i(16) と書きます）
# 書式指定子を使うと、桁数も綺麗に整うで、適材適所で使い分けてください。
puts "乗数16進数10進数"
(1..16).each do |n|
  power = 2 ** n
  printf "#{n} #{power.to_s(16)} #{power}\n", n, power, power
end
20.step(by:10, to:40) do |n|
  power = 2 ** n
  printf "#{n} #{power.to_s(16)} #{power}\n", n, power, power
end

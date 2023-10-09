# 誤差が気になる場合には、有理数型(rational number)として計算出来ます。
deposit = 1.0r # 定期預金 最後に「r」を付けます。
year    = 0 # 預けた年数

# 繰り返す回数が分からない場合は、loop 文を使います。
loop do
  deposit = deposit * 1.03r # 最後に「r」を付けます。
  year += 1

  # 定期預金が2倍以上になったら、繰り返しから脱出します。
  break if deposit >= 2
end

# 誤差なく計算することが出来ます。
puts "今年預けた定期預金は #{year} 年後に #{deposit} 倍になりました。"

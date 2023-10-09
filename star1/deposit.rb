deposit = 1.0 # 定期預金
year    = 0 # 預けた年数

# 繰り返す回数が分からない場合は、loop 文を使います。
loop do
  # deposit *= 1.03 # と書くことも出来ます。
  deposit = deposit * 1.03
  year += 1

  # 定期預金が2倍以上になったら、繰り返しから脱出します。
  break if deposit >= 2
end

# printf 文を使った例
printf "今年預けた定期預金は %d 年後に %5.3f 倍になりました。\n",
       # 長くなった場合、カンマの後で改行することも出来ます。
       year, deposit

# sprintf 文は 書式指定した文字列を返すメソッドです
# 式展開 #{} と併せて puts メソッドで出力する例です。
puts "今年預けた定期預金は #{year} 年後に #{sprintf("%5.3f", deposit)} 倍になりました。"

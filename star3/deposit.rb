# お金が2倍になる期間を知る目安として、
# 「72の法則」が知られています。
# 金利3% なら 72 ÷ 3 = 24 年で 2倍になるという法則です。

(1..4).each do |n|
  rate    = 0.03r # 金利 最後に「r」を付けると、有理数型になります。
                  # 誤差なく計算を行いたい際に用いると良いです。
  deposit = 1     # 定期預金
  year    = 0     # 預けた年数

  # 繰り返す回数が分からない場合は、loop 文を使います。
  loop do
    # 自己代入演算子を使って
    # deposit *= (1 + rate * n)
    # と書くことも出来ます。
    deposit = deposit * (1 + rate * n)
    year    += 1

    # 定期預金が2倍以上になったら、繰り返しから脱出します。
    break if deposit >= 2
  end

  # printf 文を使った例
  # printf の中で % を出力したい時には、%% と書きます。
  printf "年利 %4.1f%% の定期預金は %2d 年後に %5.3f 倍になりました。\n",
         # 長くなった場合、カンマの後で改行することも出来ます。
         (rate * 100 * n), year, deposit

  # sprintf 文は 書式指定した文字列を返すメソッドです
  # 式展開 #{} と併せて puts メソッドで出力する例です。
  puts "年利 #{sprintf("%4.1f%%", rate * 100 * n)} の定期預金は #{sprintf("%2d", year)} 年後に #{sprintf("%5.3f", deposit)} 倍になりました。"
end
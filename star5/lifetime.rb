##########################################################################
# 1980年1月1日生まれの人は、今日までに何日生きたことになるでしょうか？
# 生年月日は 19800101 と入力されます。
# 昭和20年8月10日生まれの方は、どうでしょうか？
# 生年月日は 3200810 と入力されます。
# 生後30000日目を迎えるのは、何年何月何日でしょうか？
##########################################################################

# グレゴリオ暦から修正ユリウス日を返す為の関数
def gregorian_to_mjd(year, month, date)
  # 1月や2月は前年の13月,14月として扱う
  if month == 1 || month == 2
    month += 12
    year -= 1
  end

  # 公式に従い、修正ユリウス日mjdを求める
  # \ で式が続くことを明示します
  mjd = (365.25 * year).floor       \
      + (year / 400)                \
      - (year / 100)                \
      + (30.59 * (month - 2)).floor \
      + date                        \
      - 678912

  # 算出結果を返す
  return mjd
end

# 修正ユリウス日mjdからグレゴリオ暦y, m, dを返す為の関数
def mjd_to_gregorian(mjd)
  n = mjd + 678881
  a = 4*n + 3 + 4*(3.0/4.0 * (4*(n+1)/146097 + 1)).floor
  b = 5 * ((a % 1461) / 4) + 2
  y = a / 1461
  m = b / 153 + 3
  d = b % 153 / 5 + 1
  # 1月や2月は前年の13月,14月として扱う
  if m == 13 || m == 14
    m -= 12
    y += 1
  end

  # 算出結果を配列として返す
  return [y, m, d]
end

# コマンドラインからの引数がなければ、使い方表示
if ARGV.size == 0
  puts <<~EOS
    【使い方】
    今日まで何日生きたかを表示します。
    1980年1月1日生まれであれば、
    #{$PROGRAM_NAME} 19800101
    昭和20年8月10日生まれであれば、
    #{$PROGRAM_NAME} 3200810
    の様に入力して下さい。
  EOS
  exit # プログラムを終了します。
end

# 簡易エラーチェック
birthday = ARGV[0]
if birthday.to_i == 0
  # エラーメッセージ出力
  puts "#{ARGV[0]} は、生年月日として認識出来ませんでした。"
  exit 1
end

# 生年月日に分離する
b_year  = 0
b_month = 0
b_day   = 0
# 元号入力なら、グレゴリオ暦へ変換
if birthday.length == 7
  ge      = birthday[0].to_i # 上1桁 元号符号
  # birthday[1..2]で元号年を取得し、グレゴリオ暦年に変換する
  b_year  = birthday[1..2].to_i + [0, 1867, 1911, 1925, 1988, 2018][ge]
  b_month = birthday[3..4].to_i
  b_day   = birthday[5..6].to_i
elsif birthday.length == 8
  b_year  = birthday[0..3].to_i # 上4桁はグレゴリオ暦年
  b_month = birthday[4..5].to_i
  b_day   = birthday[6..7].to_i
else
  puts "#{ARGV[0]} は、生年月日として認識出来ませんでした。"
  exit 1
end

ltm = Time.now

# 確認用
# printf  "%5d : [年]\n", ltm.year
# printf  "%5d : [月]\n", ltm.month
# printf  "%5d : [日]\n", ltm.day
# printf  "%5d : [時]\n", ltm.hour
# printf  "%5d : [分]\n", ltm.min
# printf  "%5d : [秒]\n", ltm.sec
# printf  "%5d : [曜日]\n", ltm.wday
# printf  "%5d : [経過日数]\n", ltm.yday
# printf  "%5s : [夏時間の有無]\n", ltm.isdst

t_year  = ltm.year  # 今日のグレゴリオ暦年
t_month = ltm.month # 今日の月
t_day   = ltm.day   # 今日の日

# まともに暦の日付計算をしようとすると大変なので、
# ある基準日からの経過日数を求めることにします。
# 今日は、基準日から何日目
# 誕生日は、基準日から何日目 と分かれば、
# 引き算することで、日数を計算出来ます。
# ユリウス通日（つうじつ）として知られており、
# 紀元前4713年1月1日 を第一日として、
# 天文学などの分野で用いられています。
# ユリウス通日は桁数が大きくなるので、
# ここから240万日を引いた修正ユリウス日も用いられます。
# https:#ja.wikipedia.org/wiki/ユリウス通日
# に公式がありますので、プログラミングしました。
# https:#ufcpp.net/study/algorithm/o_days.html
# にも分かりやすい説明がありますので、ご一読ください。

printf "今日は　　　 %4d 年 %2d 月 %2d 日です。\n", t_year, t_month, t_day
printf "誕生日は　　 %4d 年 %2d 月 %2d 日です。\n", b_year, b_month, b_day

# 今日の修正ユリウス日
today_mjd    = gregorian_to_mjd(t_year, t_month, t_day)
# p today_mjd
birthday_mjd = gregorian_to_mjd(b_year, b_month, b_day)
# p birthday_mjd

# 結果表示
printf "今日は生まれて %5d 日目 です。\n", today_mjd - birthday_mjd + 1

# 生まれてから30000日後がいつかを求めます。
life_30000_mjd = birthday_mjd + 30000
# l_year, l_month, l_day に分割代入され、値が戻ります。
l_year, l_month, l_day = mjd_to_gregorian(life_30000_mjd)
printf "生後三万日は %4d 年 %2d 月 %2d 日です。\n", l_year, l_month, l_day

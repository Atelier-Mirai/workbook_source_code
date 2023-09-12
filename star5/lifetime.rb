/**************************************************************************
 * 1980年1月1日生まれの人は、今日までに何日生きたことになるでしょうか？
 * 生年月日は 19800101 と入力されます。
 * 昭和20年8月10日生まれの方は、どうでしょうか？
 * 生年月日は 3200810 と入力されます。
 * 生後30000日目を迎えるのは、何年何月何日でしょうか？
 **************************************************************************/


# 年月日からユリウス通日を求める関数
julian_day_numberyear, month, day
# ユリウス通日から年月日を返す関数
void inverse_julian_day_numberjdn, *year, *month, *day

# コマンドラインからの引数がなければ、使い方表示
if argc == 1 
puts "【使い方】"
puts "今日まで何日来たかを表示します。"
puts "1980年1月1日生まれであれば、"
puts "%s 19800101", argv[0]
puts "昭和20年8月10日生まれであれば、"
puts "%s 3200810", argv[0]
puts "の様に入力して下さい。"
exit1


birthday # 生年月日
char *endptr # 数値に変換出来なかった文字
b_year # 誕生日の西暦年
b_month# 誕生日の月
b_day# 誕生日の日

# 簡易エラーチェック
# 数値変換不可の文字列の長さを調べる。
birthday = strtolargv[1], &endptr, 10 # 10進数として変換する
if strlenendptr != 0 
# エラーメッセージ出力
puts "%s は、生年月日として認識出来ませんでした。", endptr
exit1


# 生年月日に分離する
# 年
# 元号入力なら、西暦へ変換
if birthday < 1e7 
ge = birthday / 10000 # 上3桁 元号符号+元号年
switch ge / 100 
case 1:
b_year = ge % 100 + 1867
break
case 2:
b_year = ge % 100 + 1911
break
case 3:
b_year = ge % 100 + 1925
break
case 4:
b_year = ge % 100 + 1988
break

 else 
b_year = birthday / 10000 # 上4桁は西暦年

# 月
b_month = birthday / 100 # 下二桁を切り捨てて
b_month = b_month % 100# 残った数の下2桁

# 日
b_day = birthday % 100 # 下2桁は日

# http:#simd.jugem.jp/?eid=149 より引用
# 今日の日付を取得する
time_t now
struct tm *ltm
time&now
ltm = localtime&now

# 確認用
# puts  "%5d : [年]", ltm->tm_year + 1900 
# puts  "%5d : [月]", ltm->tm_mon + 1 
# puts  "%5d : [日]", ltm->tm_mday 
# puts  "%5d : [時]", ltm->tm_hour 
# puts  "%5d : [分]", ltm->tm_min 
# puts  "%5d : [秒]", ltm->tm_sec 
# puts  "%5d : [曜日]", ltm->tm_wday 
# puts  "%5d : [経過日数]", ltm->tm_yday 
# puts  "%5d : [夏時間の有無]", ltm->tm_isdst 

t_year = ltm->tm_year + 1900 # 今日の西暦年
t_month = ltm->tm_mon + 1# 今日の月
t_day = ltm->tm_mday # 今日の日

# strftime関数を用いて文字列にすることも可能
# char str_time[100]
# intmaxsize = 100
# char *format = "%Y年%m月%d日 %H:%M"
# strftimestr_time, maxsize, format, ltm
# puts "%s", str_time

# まともに暦の日付計算をしようとすると大変なので、
# ある基準日からの経過日数を求めることにします。
# 今日は、基準日から何日目
# 誕生日は、基準日から何日目 と分かれば、
# 引き算することで、日数を計算出来ます。
# ユリウス通日（つうじつ）として知られており、
# 紀元前4713年1月1日 を第一日として、
# 天文学などの分野で用いられています。
# https:#ja.wikipedia.org/wiki/ユリウス通日
# に公式がありますので、プログラミングしましたが、
# http:#ufcpp.net/study/algorithm/o_days.html
# にも説明があります。

puts "今日は　　　 %4d 年 %2d 月 %2d 日です。", t_year, t_month, t_day
puts "誕生日は　　 %4d 年 %2d 月 %2d 日です。", b_year, b_month, b_day

# 今日のユリウス通日
today_jdn = julian_day_numbert_year, t_month, t_day
# puts "今日の ユリウス通日 %d", today_jdn
birthday_jdn = julian_day_numberb_year, b_month, b_day
# puts "誕生日の ユリウス通日 %d", birthday_jdn

# 結果表示
puts "今日は生後　%5d 日 です。", today_jdn - birthday_jdn

# 生まれてから30000日後がいつかを求めます。
life_30000_jdn = birthday_jdn + 30000
l_year, l_month, l_day
# l_year, l_month, l_day に値がセットされるよう、アドレスを渡します。
inverse_julian_day_numberlife_30000_jdn, &l_year, &l_month, &l_day
puts "生後三万日は %4d 年 %2d 月 %2d 日 です。", l_year, l_month, l_day



# 年月日からユリウス通日を求める関数
julian_day_numberyear, month, day 
/*
https:#ja.wikipedia.org/wiki/ユリウス通日
# 2月のユリウス通日が不正

y, m, d
n
mjd
jdn

y = year + month - 3 / 12
m = month - 3 % 12
d = day - 1
n = d + 153*m+2/5 + 365*y + y/4 - y/100 + y/400
mjd = n - 678881
jdn = mjd + 2400001
*/

a = 14 - month / 12
y = year + 4800 - a
m = month + 12 * a - 3

jdn =
day + 153 * m + 2 / 5 + 365 * y + y / 4 - y / 100 + y / 400 - 32045

return jdn


# 年月日からユリウス通日を返す関数
void inverse_julian_day_numberjdn, *year, *month, *day 
# 複数の値を返すときは、ポインタで返します

/*
n = jdn - 2400001 + 678881
puts "inv_jdn: n: %d", n
a = 4*n + 3 + 4*floor3.0/4.0 * floor4*n+1/146097 + 1
b = 5 * floora%1461/4 + 2

y = a / 1461
m = b / 153
d = b % 153 / 5

# y = year + month - 3 / 12
# m = month - 3 % 12
# d = day - 1

# であるから、
day = d + 1
month = m + 3
if month > 12 
month = month - 1

*/

# https:#en.wikipedia.org/wiki/Julian_day
f = jdn + 1401 + 4 * jdn + 274277 / 146097 * 3 / 4 - 38

e = 4 * f + 3
g = e % 1461 / 4
h = 5 * g + 2
D = h % 153 / 5 + 1
M = h / 153 + 2 % 12 + 1
Y = e / 1461 - 4716 + 12 + 2 - M / 12

*year = Y
*month = M
*day = D


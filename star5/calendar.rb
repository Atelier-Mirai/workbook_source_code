/**************************************************************************
 * 年と月を入力すると、
 * その月のカレンダーを表示するプログラムを作ってみましょう。
 * 「ツェラーの公式」を用いると曜日を求めることが出来ます。
 * （西暦1年1月1日は月曜日となりますので、
 * ７で割った余りを求めることで、曜日が計算出来ます）
 **************************************************************************/


# ツェラーの公式Zeller's congruenceにより 曜日を返す関数
# 戻り値が 0, 1, 2, 3, 4, 5, 6 の場合、
# それぞれ 日曜日、月曜日、火曜日、水曜日、木曜日、金曜日、土曜日
zelleryear, month, day

# 今月が何日まであるかを返す
last_day_of_monthyear, month

#
# コマンドラインからの引数がなければ、使い方表示
#
if argc == 1 
puts "【使い方】"
puts "カレンダーを表示します。"
puts "2016年 6月のカレンダーであれば"
puts "%s 2016 6", argv[0]
puts "の様に入力して下さい。"
exit1 # プログラム終了


#
# 変数宣言
#
year# 西暦年
month # 月
day # 日カレンダー表示用

char *err_str # 数値に変換出来なかった文字

day_of_week # 曜日
week_number # 月の第何週か？
char *days_name[] = "日", "月", "火", "水", # 曜日の名前
 "木", "金", "土"

last_day # 今月は何日が最後の日か？

h # 今月1日が何曜日であるか？（ツェラーの公式）

#
# 簡易エラーチェック
#

# 数値変換不可の文字列の長さを調べる。
year = strtolargv[1], &err_str, 10 # 10進数として変換する
if strlenerr_str != 0 
# エラーメッセージ出力
puts "%s は、西暦年として認識出来ませんでした。", err_str
exit1 # プログラム終了

# 数値変換不可の文字列の長さを調べる。
month = strtolargv[2], &err_str, 10 # 10進数として変換する
if strlenerr_str != 0 
# エラーメッセージ出力
puts "%s は、月として認識出来ませんでした。", err_str
exit1 # プログラム終了


#
# カレンダー表示処理
#

# カレンダーの年月と曜日名を表示
puts "%4d 年 %2d 月", year, month
for day_of_week = 0 day_of_week <= 6 day_of_week++ 
puts " %s", days_name[day_of_week]

puts ""

# ツェラーの公式で、その月の１日が何曜日始まりであるか、取得する。
# 戻り値が 0, 1, 2, 3, 4, 5, 6 の場合、
# それぞれ 日曜日、月曜日、火曜日、水曜日、木曜日、金曜日、土曜日
h = zelleryear, month, 1

# 今月の最終日を求める
last_day = last_day_of_monthyear, month

# 水曜日始まりの月の場合、
# 日、月、火 の欄に日付を表示させたくないので、
# day = 1 - h からスタートする
day = 1 - h
day_of_week = 0
do 
if day < 1 
puts " " # １日以前なら空欄を出力
day++
 else 
puts " %2d", day
day++

day_of_week++
if day_of_week % 7 == 0 
puts "" # 週送り

 while day <= last_day
puts ""



# ツェラーの公式Zeller's congruenceにより 曜日を返す関数
# 戻り値が 0, 1, 2, 3, 4, 5, 6 の場合、
# それぞれ 日曜日、月曜日、火曜日、水曜日、木曜日、金曜日、土曜日
zelleryear, month, day 
y, m, d
h

# 年月日の設定
# 但し1月、2月は前年の13月、14月として計算
if month == 1 || month == 2 
y = year - 1
m = month + 12
d = day
 else 
y = year
m = month
d = day


# 曜日の算出
h = y + y / 4 - y / 100 + y / 400 + 13 * m + 8 / 5 + d % 7

return h


# 今月が何日まであるかを返す
# ldom[12] =  31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
# のように配列に値を持たせても良い。
last_day_of_monthyear, month 
switch month 
case 2:
if year % 4 == 0 && year % 100 != 0 || year % 400 == 0 
return 29
 else 
return 28

case 4:
case 6:
case 9:
case 11:
return 30

case 1:
case 3:
case 5:
case 7:
case 8:
case 10:
case 12:
return 31
default:



##########################################################################
# 年と月を入力すると、
# その月のカレンダーを表示するプログラムを作ってみましょう。
# 「ツェラーの公式」を用いると曜日を求めることが出来ます。
# （グレゴリオ暦1年1月1日は月曜日ですので、
# ７で割った余りを求めることで、曜日が計算出来ます）
##########################################################################

# ツェラーの公式Zeller's congruenceにより 曜日を返す関数
# 戻り値が 0, 1, 2, 3, 4, 5, 6 の場合、
# それぞれ 日曜日、月曜日、火曜日、水曜日、木曜日、金曜日、土曜日
def zeller(y, m, d)
  # 1月、2月は前年の13月、14月として計算
  if m == 1 || m == 2
    y -= 1
    m += 12
  end

  # 曜日の算出
  (y + y / 4 - y / 100 + y / 400 + (13 * m + 8) / 5 + d) % 7
end

# 今月が何日まであるかを返す
def last_day_of_month(year, month)
  # last_day = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  # のように配列に値を持たせても良い。
  case month
  when 2
    # 閏年判定
    if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
      return 29
    else
      return 28
    end
  # 小の月
  when 4, 6, 9, 11, 30
    return 30
  # 大の月
  when 1, 3, 5, 7, 8, 10, 12
    return 31
  end
end

# コマンドラインからの引数がなければ、使い方を表示
if ARGV.size == 0
  puts <<~EOS
   【使い方】
    カレンダーを表示します。
    2030年 6月のカレンダーであれば
    #{$PROGRAM_NAME} 2030 6
    の様に入力して下さい。
  EOS
  exit # プログラムを終了します。
end

days_name = ["日", "月", "火", "水", # 曜日の名前
             "木", "金", "土"]

#
# 簡易エラーチェック
#

# 数値変換不可の文字列の長さを調べる。
year = ARGV[0].to_i
if year == 0
  # エラーメッセージ出力
  puts "#{ARGV[0]} は、グレゴリオ暦年として認識出来ませんでした。"
  exit 1 # プログラム終了
end

# 数値変換不可の文字列の長さを調べる。
month = ARGV[1].to_i
if month == 0
  # エラーメッセージ出力
  puts "#{ARGV[1]} は、月として認識出来ませんでした。"
  exit 1 # プログラム終了
end

#
# カレンダー表示処理
#

# カレンダーの年月と曜日名を表示
printf "\n    %4d 年 %2d 月\n", year, month
(0..6).each do |day_of_week|
  printf " %s", days_name[day_of_week]
end
printf "\n"

# ツェラーの公式で、その月の１日が何曜日始まりであるか、取得する。
# 戻り値が 0, 1, 2, 3, 4, 5, 6 の場合、
# それぞれ 日曜日、月曜日、火曜日、水曜日、木曜日、金曜日、土曜日
h = zeller(year, month, 1)

# 今月の最終日を求める
last_day = last_day_of_month(year, month)

# 水曜日始まりの月の場合、
# 日、月、火 の欄に日付を表示させたくないので、
# day = 1 - h からスタートする
day         = 1 - h
day_of_week = 0

loop do
  if day < 1
    printf " " # １日以前なら空欄を出力
    day += 1
  else
    printf " %2d", day
    day += 1
  end

  day_of_week += 1
  if day_of_week % 7 == 0
    printf "\n" # 週送り
  end

  break if day > last_day
end
printf "\n"

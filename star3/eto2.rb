# 入力を促すメッセージ表示
printf "何年生まれですか? 例: S30 > "

# キー入力を受け取る
born_year = gets.chomp # chomp メソッドで改行文字を削除する

# born_year は 文字列ですが、配列のように扱えるよう[]メソッドが実装されています。
era_initial = born_year[0]   # 0 文字目を取り出します。
                             # 明治: "M", 大正: "T", 昭和: "S", 平成: "H", 令和: "R"
                             # が入ります。
era_year    = born_year[1..] # S3 や S30 と入力される場合もあるので、
                             # 1文字目以降を取り出します。
                             # "3" や "30" が入ります。

era_year     = era_year.to_i # to_i メソッドで、文字列型から整数型へと変換します。


# 年の入力が為されているか、確認する。
if era_year == 0
  # エラーメッセージ出力
  puts "年数の入力が誤っています。"
  # プログラムを終了
  exit 1 # エラーコード1(異常終了)を返します
end

case era_initial
when "M"
  year = era_year + 1867
when "T"
  year = era_year + 1911
when "S"
  year = era_year + 1925
when "H"
  year = era_year + 1988
when "R"
  year = era_year + 2018
else
  # エラーメッセージ出力
  puts "元号の文字ではありません"
  # プログラムを終了
  exit 2 # エラーコード2(異常終了)を返します
end

# 干支の算出方法は、前回と同様
# 干支の配列 12で割り切れる年は申年
eto = ["申", "酉", "戌", "亥", "子", "丑",
       "寅", "卯", "辰", "巳", "午", "未"]
printf "%c%d年(%d年)生まれのあなたの干支は、%s です。\n", era_initial,
 era_year, year, eto[year % 12]

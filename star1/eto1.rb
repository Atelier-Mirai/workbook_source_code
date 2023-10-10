year = 2000 # グレゴリオ暦年

# if 式は 条件分岐のための基本です。
# 条件が単純な場合には switch case 式を使うと、
# すっきり書くことができます。

# 12で割った余りに応じて、干支を表示します。
case year % 12
when 0
  puts "申年"
when 1
  puts "酉年"
when 2
  puts "戌年"
when 3
  puts "亥年"
when 4
  puts "子年"
when 5
  puts "丑年"
when 6
  puts "寅年"
when 7
  puts "卯年"
when 8
  puts "辰年"
when 9
  puts "巳年"
when 10
  puts "午年"
when 11
  puts "未年"
end

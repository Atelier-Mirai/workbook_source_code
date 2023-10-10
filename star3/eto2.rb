year = 2000 # グレゴリオ暦年

# case 文で、余りに応じて、それぞれの干支を表示します。
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

# 配列の各要素に、干支を格納すると、より簡潔に記述できます。
# 12で割った余りを配列の添字するのがポイントです。
eto = ["申", "酉", "戌", "亥", "子", "丑",
       "寅", "卯", "辰", "巳", "午", "未"]

# 添字を求める
index = year % 12
puts "あなたの干支は、#{eto[index]}年 です。"

# 一行に纏めて書くことも出来ます。
puts "あなたの干支は、#{eto[year % 12]}年 です。"

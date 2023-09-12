
year = 2000

# switch case 文で、余りに応じて、それぞれの干支を表示します。
switch year % 12 
case 0:
puts "申年"
break
case 1:
puts "酉年"
break
case 2:
puts "戌年"
break
case 3:
puts "亥年"
break
case 4:
puts "子年"
break
case 5:
puts "丑年"
break
case 6:
puts "寅年"
break
case 7:
puts "卯年"
break
case 8:
puts "辰年"
break
case 9:
puts "巳年"
break
case 10:
puts "午年"
break
case 11:
puts "未年"
break


# 配列の各要素に、干支を格納すると、より簡潔に記述できます。

# 12で割った余りを配列の添字するのがポイントです。
# "申"と一文字に見えますが、
# 文字コードが utf-8 の場合、3文字バイト E7 94 B3 です。
# char saru[4] =  'E7', '94', 'B3', '' 
# そして、干支は１２種類ありますから、
# 配列の配列（＝二次元配列）にすれば、干支の配列になります。
char eto[][4] = "申", "酉", "戌", "亥", "子", "丑",
 "寅", "卯", "辰", "巳", "午", "未"
# 配列の一次元目の[4]は必要です。
# 4 を書かずに、[] とだけ書くと、コンパイルエラーとなります。
# ポインタを使って次のように書くこともできます。
# char *eto[] =  "申", "酉", "戌", "亥", "子", "丑",
# "寅", "卯", "辰", "巳", "午", "未" 

index
index = year % 12
puts "あなたの干支は、%s です。", eto[index]

# 一行に纏めて書くことも出来ます。
puts "あなたの干支は、%s です。", eto[year % 12]



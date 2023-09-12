

# 縦棒グラフを表示する
# y
# ^
# | □□■□□
# | □■■□□
# | □■■■□
# | □■■■■
# | ■■■■■
# -------------> x

# 表示させたい棒グラフの値
value[] = 1, 4, 5, 3, 2
# グラフ用の二次元配列
char graph[5][5][6]] # [6]は、"□", "■"が、6文字必要なため。
# char graph[5][5]# '*', 'o' の一文字で表示するなら、これで良い。

# graph[0]
# □ graph[0][4]
# □ graph[0][3]
# □ graph[0][2]
# □ graph[0][1]
# ■ graph[0][0]

# value の値に応じて、棒グラフの長さをセットする
x, y
for x = 0 x < 5 x++ 
v = value[x]
for y = 0 y < 5 y++ 
if y < v 
# graph[x][y] = "■" # こう書きたいけれど、書けないので
# graph[x][y] = '*'# char 一文字なら、こう書ける
strcpygraph[x][y], "■"
 else 
strcpygraph[x][y], "□"
# graph[x][y] = 'o'




# グラフ表示
for y = 4 y >= 0 y-- 
for x = 0 x < 5 x++ 
puts "%s", graph[x][y]
# puts "%c", graph[x][y] # '*', 'o'
# の一文字で表示するなら、これで良い。

puts ""




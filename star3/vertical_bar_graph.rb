# グラフのX軸, Y軸の上限を定義
X_MAX = 5
Y_MAX = 7

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
values = [1, 4, 7, 3, 2]
# グラフ用の二次元配列を生成する
graph = Array.new(X_MAX) do
          Array.new(Y_MAX, ".") # 各要素を "." で初期化する
        end

# graph[0]
# □ graph[0][6]
# □ graph[0][5]
# □ graph[0][4]
# □ graph[0][3]
# □ graph[0][2]
# □ graph[0][1]
# ■ graph[0][0]
# のようにしたい。

# value の値に応じて、棒グラフの長さをセットする
(0...X_MAX).each do |x|
  value = values[x]
  (0...Y_MAX).each do |y|
    if y < value
      graph[x][y] = "■"
    else
      graph[x][y] = "□"
    end
  end
end

# グラフ表示
(Y_MAX-1).downto(0).each do |y|
  0.upto(X_MAX-1).each do |x|
    printf graph[x][y]
  end
  printf "\n"
end

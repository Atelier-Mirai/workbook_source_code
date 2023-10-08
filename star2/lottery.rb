# 実行した時刻等によって、異なった乱数となるように乱数の種を播きます。
# (いつも同じ乱数にしたければ、srand 123 の様に数を指定します)
srand

# 福引きの等級名
# 配列の添字は0から始まるので、先頭に""を入れています。
# prize_rank[1] が "一等賞"だと分かりやすいです。
prize_rank = ["", "一等賞", "二等賞", "三等賞", "残念賞"]
# 福引きの賞品
prize_item = ["", "世界一周の旅", "温泉一泊二日",
                  "お好み焼き食べ放題", "ティッシュペーパー"]

# 乱数はよく使うので、流用しています。
lottery = rand(1..10) # 福引き 1-10の乱数が得られます。

if lottery == 1
  rank = 1 # 一等賞
elsif 2 <= lottery && lottery <= 3
  rank = 2 # 二等賞
elsif 4 <= lottery && lottery <= 6
  rank = 3 # 三等賞
else
  rank = 4 # 残念賞
end

# 小さい順に切り取っているので、
# elsif の下限は省略出来ます。
if lottery == 1
  rank = 1 # 一等賞
elsif lottery <= 3
  rank = 2 # 二等賞
elsif lottery <= 6
  rank = 3 # 三等賞
else
  rank = 4 # 残念賞
end

# case 文を使って次のようにも書けます。
case lottery
when 1
  rank = 1 # 一等賞
when 2 .. 3
  rank = 2 # 二等賞
when 4 .. 6
  rank = 3 # 三等賞
else
  rank = 4 # 残念賞
end

# それぞれの等級に応じたメッセージを創っています。
message = "おめでとう！ #{prize_rank[rank]}: #{prize_item[rank]} が当たったよ。"
puts message

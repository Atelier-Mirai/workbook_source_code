# while文は繰り返す回数がわからない場合に効果的です。
# 条件を満たしているかどうかを先に判定しているので、
# 前判定型反復や前判定ループと呼ばれます。
# 前判定では、条件によっては一度も反復処理が行われず、終了することがあります。
n     = 1
total = 0
while total <= 10000
  total = total + n
  n = n + 1
end
puts "#{n-1} を足したら、10000を越えて #{total} になりました。"

# 反復処理を行った後に、
# 条件を満たしているかどうかを判定したい場合、
# Ruby には do while 文は用意されていません。
# 代えて、loop 関数を用います。
# 後判定型反復や後判定ループと呼ばれます。
# 後判定では、条件によらず一度は反復処理が行われます。
n     = 1
total = 0
loop do
  total = total + n
  n     = n + 1
  if total >= 10000
    break # 10000以上になったら、break文で反復を抜けます。
  end
end
puts "#{n-1} を足したら、10000を越えて #{total} になりました。"

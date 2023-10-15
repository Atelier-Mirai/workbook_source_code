# 定数定義
MAX      = 3 # 一度に石を取れる最大数
PLAYER   = 0
COMPUTER = 1
NAMES    = ["プレーヤー", "コンピュータ"]

# プレーヤーの取った石の数
def capture_stone(turn, stone)
  n = 0 # 取る石の数
  case(turn)
  # プレーヤーの番なら、取りたい個数を入力する
  when PLAYER
    loop do
      puts "石を何個取りますか(1-3)"
      n = gets.chomp.to_i
      break if n.between?(1,3) && n <= stone # その場にある石の数を超えない
    end
  # コンピュータの番なら
  when COMPUTER
    # 4個以下の時には一つ残して取る
    if stone <= 4
      n = stone - 1
    else
      # 乱数で適当に取る
      n = rand(1..3)
    end
  end
  n
end

# 石の表示
def disp_stone(stone, stone_max)
  # times（回数）メソッドを使うと
  # {} で与えられたブロックを、
  # 回数分繰り返すことができます。
  stone.times { printf "●" }
  (stone_max - stone).times { printf "○" }
  puts ""
end

# 変数宣言
# stone_max # 場にある石の最大数
# stone# 場にある石の数
# n# 競技者が取った石の数
# char turn# どちらの番か？

# 乱数で石の総数を決めます
stone_max = rand(0..4) + 20
stone     = stone_max

# オープニング
puts "======== 石取りゲーム ========"
puts "交互に１〜３個の石を取ります。"
puts "最後の一個を取ると負けです。"
puts "最初は #{stone} 個の石があります。"

# 先攻後攻
puts "先攻しますか？ Y/N"
turn = gets.chomp.upcase # 小文字の"y" が押されるかも知れないので、
                         # upcase メソッドで大文字に変換します。

if turn == "Y"
  # turn は "Y"という文字列を指していましたが、
  # PLAYER という 整数型の値を指すように変更できます。
  turn = PLAYER
  puts "プレーヤーの先攻です"
else
  turn = COMPUTER
  puts "コンピュータの先攻です"
end

puts "\n======== ゲーム開始 ========\n"

# 石を交互にとる
loop do
  printf "%sの番です\n", NAMES[turn]
  printf "%d 個の石が残っています\n", stone
  disp_stone(stone, stone_max)
  n = capture_stone(turn, stone)
  puts "#{n} 個の石を取りました。\n\n"
  stone -= n
  turn = (turn+1) % 2 # 交代

  break if stone == 0
end

# エンディング
printf "%sの勝ちです\n", NAMES[turn]

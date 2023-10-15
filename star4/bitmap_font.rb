# 数を表示するための関数
def show_font(number)
  (0...5).each do |row|
    # 一行目のデータを取り出す
    data = number[row]
    (0...4).each do |column|
      # 覆い隠すためのマスクを用意する
      mask = 0b1000
      # column ビット 左シフトする
      #mask = 0b1000 -> 0b0100 -> 0b0010 -> 0b0001 と変化していく
      mask = mask >> column
      # mask と ビット論理積&を取ると、
      # data の 3bit目が 0 か 1 かを 判定できる
      # puts "確認: %x & %x = %x", data, mask, data & mask
      if (data & mask) != 0
        printf "■"
      else
        printf "□"
      end
    end
    puts ""
  end
end

# ビットマップフォントの定義
# 0-9まで、それぞれの数字の形になるよう、
# 二進数でビットを立てます。
bitmap =[[0b1111, # 0
          0b1001,
          0b1001,
          0b1001,
          0b1111],

         [0b0001, # 1
          0b0001,
          0b0001,
          0b0001,
          0b0001],

         [0b1111, # 2
          0b0001,
          0b1111,
          0b1000,
          0b1111],

         [0b1111, # 3
          0b0001,
          0b1111,
          0b0001,
          0b1111],

         [0b1001, # 4
          0b1001,
          0b1111,
          0b0001,
          0b0001],

         [0b1111, # 5
          0b1000,
          0b1111,
          0b0001,
          0b1111],

         [0b1111, # 6
          0b1000,
          0b1111,
          0b1001,
          0b1111],

         [0b1111, # 7
          0b1001,
          0b1001,
          0b0001,
          0b0001],

         [0b1111, # 8
          0b1001,
          0b1111,
          0b1001,
          0b1111],

         [0b1111, # 9
          0b1001,
          0b1111,
          0b0001,
          0b1111]]

# 定義した書体に従い、数を表示する
(0..9).each do |n|
  # bit が立っているところを🔲、
  # 立っていないところを□として、表示させます。
  show_font(bitmap[n])
  puts ""
end

# 自作の関数を創って、解くことも出来ます。

# 関数宣言
# 機能：黒い■と白い□を表示する
# 引数：black_number # 黒い■の数
#       white_number # 白い□の数
# 戻値：なし
def black_white_number(black_number, white_number)
  # （特に指定しなければ）
  # 最後に演算した結果が、関数の戻り値となります。
  "■" * black_number + "□" * white_number + "\n"
end

(0...5).each do |row|
  black_number = 5 - row # 黒い■の数
  white_number = row     # 白い□の数

  # black_white_number関数を呼び出し、
  # 結果を print メソッドで表示します。
  print black_white_box(black_number, white_number)
end

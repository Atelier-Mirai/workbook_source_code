# 自作の関数を創って、解くことも出来ます。

# 関数宣言
# 機能：黒い■と白い□を表示する
# 引数：black_number # 黒い■の数
#       white_number # 白い□の数
# 戻値：なし
def black_white_box(black_number, white_number)
  # （特に指定しなければ）
  # 最後に演算した結果が、関数の戻り値となります。
  "■" * black_number + "□" * white_number + "\n"
end

# 引数が一つだけならば良いですが、
# 複数ある場合には順番がわからなくなることもあります。
# 「キーワード引数」を使うと、順番を気にすることなく、
# 関数を呼び出すことが出来ます。
def black_white_box_with_keyword(black_box: black, white_box: white)
  # （特に指定しなければ）
  # 最後に演算した結果が、関数の戻り値となります。
  "■" * black_box + "□" * white_box + "\n"
  # "■" * black ではなく、
  # "■" * black_box と「キーワード名」を書いていることに注意してください。
end

# 表示させたい棒グラフの値配列
values    = [1, 4, 7, 3, 2]
max_value = values.max

# 値配列から要素を取り出し、繰り返します。
values.each do |value|
  black_number = value             # 黒い■の数
  white_number = max_value - value # 白い□の数

  # black_white_box 関数を呼び出し、結果を表示します。
  print black_white_box(black_number, white_number)
end


# キーワード引数を用いて、メソッド呼び出しを行う例です。
# white, black の順で引数を指定しても、支障なく動作します。
values.each do |value|
  black_number = value             # 黒い■の数
  white_number = max_value - value # 白い□の数
  print black_white_box_with_keyword(white_box: white_number,
                                     black_box: black_number)
end

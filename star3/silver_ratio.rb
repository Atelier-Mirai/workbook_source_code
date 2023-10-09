#==============================================================================
# 【白銀比】
# 長方形を二つ折りにした時にできる長方形が、元の長方形と相似である時の
# 長辺と短辺の比を「白銀比」と言います。
#           x
#     ---------------
#   1 |      |      | 1
#     |      |      |
#     ---------------
#              x/2
#
# 大きな長方形は、長辺 x : 短辺 1
# 二つ折りにした小さな長方形は、長辺 1 : 短辺 x/2
# これが相似なので、
# x : 1 = 1 : x/2
# が成り立ちます。
# 外項の積は内項の積に等しいので
# x(x/2) = 1
# x^2 = 2
# x = √2 と求められます。
#
# 二つ折りにして元の紙と相似という性質は、印刷製本の際にとても便利です。
# 紙の大きさの規格として、A3, A4 用紙、B4, B5 用紙をよく見かけますが、
# A3用紙を二つ折りにするとA4用紙、B4用紙を二つ折りにするとB5用紙になります。
# また、A4用紙の面積を1.5倍にしたものがB4用紙です。
#
# A0 用紙の面積を1㎡平方メートル）として、
# それを二つ折りにしたものがA1, それをさらに二つ折りにしたものがA2と、
# A0, A1, A2, ... A10 まで規格されています。
# それぞれの紙の大きさを求めてみましょう。
# （ミリメートル単位で求め、端数を切り捨てます。）
#
# 【参考】
# https://www.tcpc.co.jp/columns/index049
#==============================================================================

# 短辺と長辺を与えると、二つ折りにした紙の長さを返す関数
def half_swap(short_side, long_side)
  # long_side / 2 の演算では、分子、分母ともに整数型での演算なので、
  # 端数は切り捨てられます。
  # また、a, b = b, a と書くと、それぞれの値を入れ替えることができます。
  short_side, long_side = long_side/2, short_side
end

# A0版の面積は1m2平方メートルです。
# 面積が1m2ですから、概ね一辺1mくらいと察しがつきます。
# 長辺の長さは短辺の長さの√2倍=２^0.5 ２の0.5乗
# という関係がありますから、
# -0.25 0.25 0
# ２ × ２＝ ２
# 短辺長辺 面積
# であることが分かります。（指数の法則を思い出してください。）

# 短辺の長さ
short_side = (2**-0.25 * 1000).round # mm 単位にして、
                                     # roundメソッドで端数を四捨五入。
                                     # 整数型にします。
# 長辺の長さ
long_side  = (2**0.25 * 1000).round

# A0版, A1版, A2版 ... A10版 まで
(0..10).each do |n|
  printf "A%2d版 短辺 %4d mm 長辺 %4d mm\n", n, short_side, long_side
  short_side, long_side = half_swap(short_side, long_side)
end
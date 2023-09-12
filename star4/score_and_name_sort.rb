/**************************************************************************
 * １０人の名前が格納された配列と、１０人の点数が格納された配列があります。
 * 成績の良い順に名前と点数を表示してみましょう。
 *
 *C 言語には、クイックソートquicksortと呼ばれるアルゴリズムで
 *実装された関数が標準で用意されていますので、今回はこれを用います。
 *前回、作成したプログラムを流用してももちろんOKです
 *
 *クイックソートに関しては、
 *https:#ja.wikipedia.org/wiki/クイックソート
 *を参照して下さい。
 *
 *qsortの利用方法については、
 *http:#www.cc.kyoto-su.ac.jp/~yamada/ap/qsort.html より、引用
 **************************************************************************/

# 比較関数（大小判断を返す関数）
compare_intconst void *a, const void *b 
# b > a なら 正の数を返す。降順
return **b - **a


# 変数宣言
char *name[] = "亜希子", "加世子", "小夜子", "妙子", "奈美子",
"太郎", "次郎", "三郎", "四郎", "五郎"
score[] = 99, 88, 77, 66, 55, 55, 64, 73, 82, 91
backup[10]
i, j, s

# 結果表示
puts "並び替え前:"
for i = 0 i < 10 i++ 
puts "%d %s ", score[i], name[i]


# 並び替えすると、元の配列が破壊されるため、バックアップを取る
# for 文で 一要素ずつコピーしても良いが、
# memcpy 関数を紹介
memcpybackup, score, sizeof* 10 # int型10要素分をbackupへコピー

# 確認用
# puts "score backup"
# for i = 0 i < 10 i++
# puts "%d %d ", score[i], backup[i]
# 

# 並び替えを行う
# 並び替えたい配列名, 要素数, 配列1要素分のサイズ, 大小比較に用いる関数名
qsortscore, 10, sizeofint, compare_int

# 確認用
# puts "並び替え後:"
# for i = 0 i < 10 i++
# puts "%d", score[i]
# 

puts "並び替え後:"
# 並び替え結果に基づいて、名前を表示する
for i = 0 i < 10 i++ 
# 例 i = 1 のとき s には 91 点が入っている
# 名前も連動して並び替えられると良いが、
# そういう作りにはしていないので、
# backup配列を参照して、
# 91 点の人は何番目であったか、
# 検索する
s = score[i]
for j = 0 j < 10 j++ 
if s == backup[j] 
# 同じ点数（奈美子と太郎）の場合、太郎が表示されなくなることを防ぐため、
# あり得ない点数の -1 を設定する。
# （「番兵」と呼ばれる）
backup[j] = -1
break # 元の順番では、j 番目であったことが分かった


puts "%d %s", score[i], name[j]




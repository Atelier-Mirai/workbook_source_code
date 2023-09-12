/**************************************************************************
 * 完全数とは次のような数のことです。
 * ６は、１でも２でも３でも割り切れます。そして６＝１＋２＋３です。
 * ２８は、１と２と４と７と１４で割り切れます。
 * １と２と４と７と１４を足すと２８になります。
 * ２８の次の完全数は、いくつでしょうか？
 **************************************************************************/


# 完全数判定関数
is_perfectcandidate

# 6= 2 * 3
# 28 = 2^2 * 7 である
# 割り切れるかどうかを調べ、
# 割り切った合計が、もとの数と一致するか調べればよい。

perfect_array[4] = 6, 28
perfect_index = 2

candidate = 28 + 2 # 奇数の完全数は知られていないため、
# 28 の次の偶数を候補とする

while 1 
# 完全数かどうかの判定は、is_perfect関数に任せ、
# 完全数が発見されるまで、繰り返す
if is_perfectcandidate 
# 完全数が発見されたら追加
perfect_array[perfect_index] = candidate
perfect_index++
if perfect_index == 4 
break
 else 
candidate += 2

 else 
candidate += 2



# 結果表示
for i = 0 i < perfect_index i++ 
puts " %d 番目の完全数は、%5d です。", i + 1, perfect_array[i]



# 完全数判定関数
is_perfectcandidate 
sum = 0 # 総和
i

for i = 1 i < candidate i++ 
if candidate % i == 0 
sum += i


if sum == candidate 
return TRUE
 else 
return FALSE



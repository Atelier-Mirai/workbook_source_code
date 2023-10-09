##########################################################################
# 完全数とは次のような数のことです。
# ６は、１でも２でも３でも割り切れます。そして６＝１＋２＋３です。
# ２８は、１と２と４と７と１４で割り切れます。
# １と２と４と７と１４を足すと２８になります。
# ２８の次の完全数は、いくつでしょうか？
##########################################################################

# 完全数判定関数
# 慣例として、true / false を返す関数名の末尾には ? を付けます。
# 6= 2 # 3
# 28 = 2^2 # 7 である
# 割り切れるかどうかを調べ、
# 割り切った数の合計が、もとの数と一致するか調べればよい。
def perfect?(candidate)
  sum = 0
  (1...candidate).each do |i|
    sum += i if candidate % i == 0
  end

  if sum == candidate
    return true
  else
    return false
  end
end

perfect_numbers = []
candidate       = 2 # 奇数の完全数は知られていないため、
                    # 最初の偶数を候補とする

# 最初の四つの完全数が発見されるまで繰り返す
loop do
  # 完全数の判定は、perfect?関数で行い、
  # 完全数が発見されたら追加する
  perfect_numbers << candidate if perfect?(candidate)
  candidate += 2
  break if perfect_numbers.size == 4
end

# 結果表示
perfect_numbers.each.with_index(1) do |number, index|
  printf "%d 番目の完全数は %5dです。\n", index, number
end

##########################################################################
# １と自分自身以外で割り切れない数のことを「素数」と言います。
# １〜１００までの間の素数を表示してみましょう。
# また１０００個目の素数は何でしょうか？
##########################################################################



# 素数判定関数
def prime?(candidate, prime_numbers)
  # 10000=100#100 が 素数かどうかを調べるには、
  # 100までの素数で割りきれるかどうか、確認すれば良い。
  # ここでは簡単化のために、今までに判明している全ての素数で割り切れるか確認する。
  prime_numbers.each do |prime|
    # 割り切れるかどうか
    if candidate % prime == 0
      # 割り切れたなら、素数ではない。
      return false
    end
  end

  return true
end


prime_numbers = [2] # 2 は 偶数唯一の素数である。
candidate     = 3   # 素数候補 3から始める

while candidate < 10000
  # 素数かどうかの判定は、is_prime関数に任せ、
  # 素数であったら、配列に追加する
  prime_numbers << candidate if prime?(candidate, prime_numbers)
  candidate += 2 # 奇数の候補のみ調べるので、+2 している
end

# 結果表示
# （せっかくなので、10000までの素数表示）
printf "      |     1     2     3     4     5     6     7     8     9    10\n"
printf "------+------------------------------------------------------------\n"
prime_numbers.each_with_index do |prime, index|
  printf "%5d | ", index if index % 10 == 0
  printf "%5d ", prime
  # 10 個 ずつ 改行
  printf "\n" if (index + 1) % 10 == 0
  # 100個ずつ線を表示
  printf "------+------------------------------------------------------------\n" if (index + 1) % 100 == 0
end
printf "\n"

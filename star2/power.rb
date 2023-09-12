
n
long power = 1

# ２の冪乗べきじょうを求めます。
for n = 1 n <= 20 n++ 
power *= 2
puts "2 の %2d 乗は %8ld です。", n, power


# 冪乗を求める関数も用意されています。
for n = 1 n <= 20 n++ 
power = pow2, n
puts "2 の %2d 乗は %8ld です。", n, power


# 16進数で出力する際は、%x を指定します。
# ここでは、power が long 型なので %lx を指定します。
# 10進数と16進数との対応も参考までに出力してみます。
puts "乗数16進数10進数"
for n = 1 n <= 16 n++ 
power = pow2, n
puts "%2d %11lx %13ld", n, power, power

for n = 20 n <= 40 n += 10 
power = pow2, n
puts "%2d %11lx %13ld", n, power, power





multiplier # 乗数　（掛ける数）
multiplicand # 被乗数 （掛けられる数）

# 掛け算九九の表を表示する
puts " 一 二 三 四 五 六 七 八 九"
puts " の の の の の の の の の"
puts " 段 段 段 段 段 段 段 段 段"
for multiplier = 1 multiplier <= 9 multiplier++ 
for multiplicand = 1 multiplicand <= 9 multiplicand++ 
puts "%3d", multiplicand * multiplier

puts ""




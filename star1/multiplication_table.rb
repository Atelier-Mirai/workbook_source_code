# 掛け算九九の表を表示する
puts " 一 二 三 四 五 六 七 八 九"
puts " の の の の の の の の の"
puts " 段 段 段 段 段 段 段 段 段"
(1..9).each do |multiplier|     # 乗数　（掛ける数）
  (1..9).each do |multiplicand| # 被乗数 （掛けられる数）
    printf "%3d", multiplicand * multiplier
  end
  printf "\n"
end

##########################################################################
# １０人の名前が格納された連想配列（ハッシュ）があります。
# 成績の良い順に名前と点数を表示してみましょう。
#
# Ruby には、連想配列（ハッシュ）を並び替える為の sort_by メソッドが
# 標準で用意されていますので、今回はこれを用います。
# sort_by メソッド
# https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/sort_by.html
##########################################################################

scores = { 亜希: 55, 加世: 88, 小夜: 77, 多実: 66, 奈美: 55,
           太郎: 55, 次郎: 64, 三郎: 73, 四郎: 82, 五郎: 91 }

# 結果表示
puts "並び替え前"
scores.each do |name, score|
  puts "#{name} #{score}"
end

puts "並び替え後"
# -score とすることで、降順にできます。
sorted_scores = scores.sort_by { |_, score| -score }.to_h
sorted_scores.each do |name, score|
  puts "#{name} #{score}"
end

puts "並び替え後"
# 安定な並び替え(比較結果が同じなら元の順序通りに出力)を
# 実現する為には次のようにします。
# 亜希: 55, 奈美: 55, 太郎: 55 の出力順に着目してください。
i = 0
sorted_scores = scores.sort_by { |_, score| [-score, i += 1] }.to_h
sorted_scores.each do |name, score|
  puts "#{name} #{score}"
end

# 降水確率 0 - 100 % の範囲の乱数
# 補完機能が働くので、長い変数名でも良いですが、長すぎるかもしれません。
# 分かりやすいプログラムを書くために、
# 良い名前を付けてください。
# 降水確率は 10% 単位なので、0〜10までの乱数を10倍しています。
precipitation_probability = rand(0..10) * 10

# #{precipitation_probability} は「式展開」と呼ばれる書き方です。
# 実際の precipitation_probability の値に展開されて、出力されます。
puts "降水確率は #{precipitation_probability} % です"

# if else 文の条件式は、
# 大きい順、あるいは、小さい順にして、
# 順次、条件に合致させるようにするとよいです。
if  precipitation_probability <= 30
  puts "傘はいらないです"
elsif  precipitation_probability <= 70
  puts "持って行った方がいいかも"
else
  puts "絶対持って行きましょう"
end

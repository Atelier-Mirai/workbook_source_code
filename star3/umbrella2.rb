# コマンドラインから、降水確率を渡すことも出来ます。

# 使い方の説明表示
# ($PROGRAM_NAME はプログラム自身の名前です。)
if ARGV.size == 0
  puts <<~EOS
   【使い方】
   傘を持っていくべきか、助言するプログラムです。
   もし降水確率が 30% なら
   #{$PROGRAM_NAME} 30
   と入力して下さい。
  EOS
  exit # プログラムを終了します。
end

# to_i は、整数型に変換するメソッドです。
# プログラムに渡された最初の引数ARGV[0]を受け取り、
# 整数型に変換、precipitation_probability に代入しています。
precipitation_probability = ARGV[0].to_i

# case式のwhen節には、範囲オブジェクトを指定することも出来ます。
case precipitation_probability
when (0..30)
  puts "傘はいらないです"
when (30..70)
  puts "持って行った方がいいかも"
else
  puts "絶対持って行きましょう"
end

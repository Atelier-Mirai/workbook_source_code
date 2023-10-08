# 大きな数が読みやすいように
# 適宜「_(アンダースコア)」を入れることが出来ます。
population  = 80_0000_0000 # 世界人口 80億人
growth_rate = 0.01         # 人口増加率 1%

# 来年の人口
next_year_population = population * (1 + growth_rate)
puts "来年の人口は %ld 人です。", next_year_population

# 何年後に100億人になるか、求めてみましょう。
# 繰り返す回数が分からない場合は、loop 文を使います。
year = 0
loop do
  # 人口が 100億人未満なら
  if population < 1e10            # 1e10 は、10の10乗=100億です。
    population *= 1 + growth_rate # 人口増加率を掛けます。
    year += 1                     # 年数を増やします。
    # 結果表示
    puts "#{year}年後の人口は #{population}人です。"
  # そうでなければ（100億人以上なら）
  else
    break                         # 中断して、繰り返しを抜けます。
  end
end

# おまけ
# ３桁ごとにカンマ区切りで出してみましょう。
# 数としての人口を文字列に変換します。

# 世界人口が入った文字列
str_population = "8000000000"
# カンマは、最後の桁から3つごとに入れていきます。
# 最後から数えて3つずつカンマを入れていくのは、
# 扱いにくいので、先頭から3つずつ入れていけば良いように、
# 逆順に並び替えます。
# 8000000000 -> 0000000008
# Ruby には、文字列を逆順にするメソッド reverse が用意されています。

# 逆順になっている文字列（作業用）
str_population_reverse = str_population.reverse
puts "逆順に並び替えて、#{str_population_reverse} となりました。"

# 3桁ごとにカンマを入れていきます。
# "0000000008" という文字列を、先頭から三桁ごとに区切ります。
# /\d{3}/ は「正規表現」と呼ばれる記法で、
# 特定のパターンに一致するか、調べる為のミニ言語です。
# \d{1,3} は数字一桁〜三桁を意味する正規表現です。
# scanメソッドと併用すると、
# 数字三桁に該当する文字列が、都度都度、配列要素として取り出されます。
three_digit = str_population_reverse.scan(/\d{1,3}/)
puts "三桁ごとに区切った配列です。"
# p メソッドは、配列であることを分かりやすく表示します。
p three_digit

# join メソッドは配列のそれぞれの要素を「指定した文字」で繋げることが出来ます。
# ここでは「,」で繋げるようにします。
# カンマを入れて逆順になっている文字列（作業用）
str_comma_population_reverse = three_digit.join(",")
puts "カンマを追加して #{str_comma_population_reverse} となりました。"

# もう一度、並び替えます。
str_comma_population = str_comma_population_reverse.reverse
puts "もう一度並び替えて、#{str_comma_population} となりました。"

# C言語の例に倣って、一行ずつ書いてきましたが、
# 中間変数を省いて、全部を一行で書くことも出来ます。
str_comma_population = 8000000000.to_s.reverse.scan(/\d{1,3}/).join(",").reverse
puts "一行で書けて、#{str_comma_population} となりました。"

# カンマ区切りは良く使うので、自作のメソッドにしておくと、使い勝手が良いです。
# 三桁ごとカンマ区切りにするメソッド
def number_with_delimiter(number)
  number.to_s.reverse.scan(/\d{1,3}/).join(",").reverse
end

# 次のように使います。
str_comma_population = number_with_delimiter(8000000000)
puts "自作メソッドを使って #{str_comma_population} となりました。"

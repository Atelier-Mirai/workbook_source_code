/**************************************************************************
 * 閏年を算出します。
 **************************************************************************/

# 分かりやすさのために、TRUE, FALSE という定数を定義します。
# 定数は全て大文字で書く慣習です。

# 関数のプロトタイプ宣言
# 西暦年を渡して、閏年なら、TRUEを返す関数
leap_year1year
leap_year2year

# コマンドラインから、引数を渡すことも出来ます。
if argc == 1 
puts "【使い方】"
puts 
"閏年leap yearか、平年common yearか、算出するプログラムです。"
puts "%s 2016", argv[0] # argv[0] はプログラム自身の名前です。
puts "の様に西暦年で入力して下さい。"

exit1 # プログラムを終了します。


year # 西暦年
char *endptr # 数値に変換出来なかった文字
# atoi関数は、文字列を数値に変換出来なかった場合にでも、0を返します。
# 本当に、"0" という文字列が、0 という数値に変換されたのか、
# 区別が出来ないので、strtol関数を使います。
year = strtolargv[1], &endptr, 10 # 10進数として変換する

# 数値変換不可の文字列の長さを調べる。
if strlenendptr != 0 
# エラーメッセージ出力
puts "%s は、西暦年として認識出来ませんでした。", argv[1]
exit1 # エラーコード 1 として、異常であることを伝えて終了します。


# 閏年かどうかはよく使うので、自作の関数を創って、判定することにします。
# leap_year1 : 長いif文の関数
if leap_year1year == TRUE 
puts "閏年です。"
 else 
puts "平年です。"


# leap_year2 : 整理したif文の関数
if leap_year2year == TRUE 
puts "閏年です。"
 else 
puts "平年です。"



# 西暦年を渡して、閏年なら、TRUEを返す関数
leap_year1year 
# 4で割り切れる年は閏年です。
# 但し100で割り切れる年は閏年ではありません。
# しかしながら、400で割り切れる年は、閏年です。

# 素直にif文で書くと次のようになります。
# if文の中にif文を書くことも出来ます。
if year % 4 == 0 
# 4で割り切れる年は閏年ですが、例外があるので、例外を書きます。
if year % 100 == 0 
# 但し100で割り切れる年は閏年ではありません。とありますが、
# さらにこれの例外があるので、例外を書きます。
if year % 400 == 0 
# しかしながら、400で割り切れる年は、閏年です。とあるので、
# TRUEを返します。
return TRUE
 else 
# 400で割り切れなかった年です。
return FALSE

 else 
# 100で割り切れなかった年です。
return TRUE

 else 
# 4で割り切れなかった年です。
return FALSE



# 西暦年を渡して、閏年なら、TRUEを返す関数
leap_year2year 
# 4で割り切れる年は閏年です。
# 但し100で割り切れる年は閏年ではありません。
# しかしながら、400で割り切れる年は、閏年です。

# 素直にif文を書くとすごく長くなってしまいました。
# if else が複雑になっていて、合っているのか間違っているのか、
# 確認するのも大変です。

# 4で割り切れる.......a
# 100で割り切れる.....b
# 400で割り切れる.....c
# と条件が複合しているので、
# 閏年かどうか........x
# 表にして整理すると、分かりやすいです。
# （真偽値表、カルノー図と言います）

# 割り切れることを TRUET
# 割り切れないことを FALSEF として、表にしてみましょう。
# ８とおりの組み合わせが出来ます。
# - が入っているところは、あり得ない組み合わせのところです。
# 4 で割り切れなければ、当然、100 でも 400 でも割り切れませんものね。

# a b c x
# F - - F ... 1
# F - - F ... 2
# F - - F ... 3
# F - - F ... 4
# T F - T ... 5
# T F - T ... 6
# T T F F ... 7
# T T T T ... 8

# 表を見ると、5 と 6 は同じですので、
# 5 または 8の場合で、閏年になることが分かります。
# つまり、
# 4で割り切れて、100で割り切れない年
# または、
# 4で割り切れて、100で割り切れて、400で割り切れる年=400で割り切れる年
# の場合に閏年になることが分かります。

# よって次のif文でよいことが分かります。
if year % 4 == 0 && year % 100 != 0 || year % 400 == 0 
return TRUE
 else 
return FALSE

# 1600, 1700, 2000, 2004, 2099, 2100年を入れて、確認してみましょう。
# （どのテストケースで確認すべきか、考えるのも大切です）


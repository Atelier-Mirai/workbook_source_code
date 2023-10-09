##########################################################################
# 算用数字 302 を 漢数字にします。
# 無量大数までの変換が出来ます。
# 参考: https://ja.wikipedia.org/wiki/命数法
#
# 正規表現については、
# https:#ja.wikipedia.org/wiki/正規表現
# https://rubular.com 参照
##########################################################################/

# 漢字変換に用いる定数
DIGIT = ["〇", "一", "二", "三", "四",
         "五", "六", "七", "八", "九"]
UNIT1 = ["千", "百", "十", ""]
UNIT2 = [  "", "万", "億","兆", "京",
         "垓", "𥝱", "穣","溝", "澗",
         "正", "載", "極","恒河沙", "阿僧祇",
         "那由他", "不可思議", "無量大数"]

# 4桁 の 漢数字へ変換する関数（メソッド）
def num2kan(four_digit_number)
  # 変換後の漢数字
  chinese_numeral = ""

  # 一つずつ漢数字に変換する
  # 引数four_digit_number に "3776"が渡されると
  # scan(/\d/)で 配列["3", "7", "7", "6"]に変換
  # map(&:to_i) で 配列[3, 7, 7, 6]に変換する。
  # each_with_indexメソッドで、繰り返し処理を実行する。
  # 初回は number には 3, index には 0 が渡される
  four_digit_number.scan(/\d/).map(&:to_i).each_with_index do |number, index|
    case number
    when 0
      # 何もせず、次の桁へ進む
    when 1
      # 一の位のみ "一"と書く
      chinese_numeral << "一" if index == 3
      # "千", "百", "十", "" のいずれかを付与
      chinese_numeral << UNIT1[index]
    else
      # // "一" 〜 "九"
      chinese_numeral << DIGIT[number]
      # "千", "百", "十", "" のいずれかを付与
      chinese_numeral << UNIT1[index]
    end
  end
  # 変換結果を返す
  return chinese_numeral
end

# コマンドラインからの引数がなければ、使い方を表示
if ARGV.size == 0
  puts <<~EOS
   【使い方】
    算用数字を漢数字にするプログラムです。無量大数まで変換出来ます。
    #{$PROGRAM_NAME} 1234567890
    の様に入力して下さい。
    十二億三千四百五十六万七千八百九十
    を表示します
  EOS
  exit # プログラムを終了します。
end

# コマンドライン引数チェック
# '0'-'9' 以外の文字が含まれていたら、エラー表示し、終了する。
# （正規表現を用いたが、一桁ずつ読み込み、'0'-9 か、チェックしても良い
# 正規表現のRubyでのコーディングについては、
# 公式サイト https://docs.ruby-lang.org/ja/latest/doc/spec=2fregexp.html
# を参考にしてください。

reg = /^[0-9]+$/ # 全て数字であるか判定するための正規表現

# ARGV[0]が、正規表現にマッチするか、実行
# Ruby  には、「条件を満たさない場合」に実行される unless 式があります。
# (if !r.match(reg) と書くことも出来ます)
unless ARGV[0].match(reg) # マッチしない場合
  puts "#{ARGV[0]} は 算用数字として認識出来ませんでした。"
  exit 1
end

# 最大取り扱い桁数 9999無量大数(10^68)までの数
if ARGV[0].length > 4 + 68 + 1
  puts "#{ARGV[0]} は 長すぎます。73桁までの数字を入力して下さい。"
  exit 1
end

# 漢数字への変換処理
# 4桁ごとに区切って変換できるよう、先頭に0を付与する
# 12 3456 7890 => 0012 3456 7890
giving_zero = 4 - ARGV[0].length % 4 # 先頭に付与すべき0の数
giving_zero %= 4                     # 4 なら 0 にする
string_number = "0" * giving_zero + ARGV[0]

# /\d{4}/は、数字四桁を意味する正規表現です。
# scanメソッドと併用し、
# 数字四桁に該当する文字列が、都度都度、配列要素として取り出し、
# 配列four_digit_numbers に格納します。
four_digit_numbers = string_number.scan(/\d{4}/)

#  4桁までなら unit2 ""
#  8桁までなら unit2 "万"
# 12桁までなら unit2 "億"
# 等を付与する
chinese_numeral = ""
four_digit_numbers.each_with_index do |for_digit, index|
  # 4桁毎に漢数字に変換、結果を連結する
  chinese_numeral << num2kan(for_digit)
  # "0012 3456 7890" の場合、
  # 最初の変換結果 "十二" に "億" を、
  # 　次の変換結果 "三千四百五十六" に "万" を、
  # 最後の変換結果 "七千八百九十" に "" を付ければ良い。
  # 億", "万", "" の付与
  unit2_index = four_digit_numbers.size - index - 1
  chinese_numeral << UNIT2[unit2_index]
end

# 0 の場合のみ、空文字列のままなので、"〇" にする。
chinese_numeral = "〇" if chinese_numeral == ""

# 結果表示
puts chinese_numeral

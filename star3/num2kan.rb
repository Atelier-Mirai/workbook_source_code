/**************************************************************************
 * 算用数字 302 を 漢数字にします。
 * 無量大数までの変換が出来ます。
 * 参考: https:#ja.wikipedia.org/wiki/命数法
 *
 * 正規表現については、
 * https:#ja.wikipedia.org/wiki/正規表現
 * http:#rubular.com 参照
 **************************************************************************/

# 漢字変換に用いる定数
# main の外側に書かれているので、どの関数からでも参照可能
# const は 変更禁止の為の修飾子
const char *digit[] = "〇", "一", "二", "三", "四",
 "五", "六", "七", "八", "九"
const char *unit1[] = "千", "百", "十", ""
const char *unit2[] = "", "万", "億","兆", "京",
 "垓", "𥝱", "穣","溝", "澗",
 "正", "載", "極","恒河沙", "阿僧祇",
 "那由他", "不可思議", "無量大数"

# 4桁の漢数字への変換を行う関数
char *num2kanchar *str


# コマンドラインからの引数がなければ、使い方表示
if argc == 1 
puts "【使い方】"
puts 
"算用数字を漢数字にするプログラムです。無量大数まで変換出来ます。"
puts "%s 302", argv[0]
puts "の様に入力して下さい。"
exit1


# コマンドライン引数チェック
# '0'-'9' 以外の文字が含まれていたら、エラー表示し、終了する。
# （正規表現を用いたが、一桁ずつ読み込み、'0'-9 か、チェックしても良い

# 正規表現のC言語でのコーディングについては、
# http:#atomic.jpn.ph/prog/lang/regex.html 参照

char *reg = "^[0-9]+$" # 全て数字であるか判定するための正規表現
regex_t regst
# 正規表現のコンパイル
if regcomp&regst, reg, REG_EXTENDED 
return 1

# argv[1]が、正規表現にマッチするか、実行
if regexec&regst, argv[1], 0, NULL, 0  # マッチしない場合
puts "%s は 算用数字として認識出来ませんでした。", argv[1]
exit1

# コンパイル結果の開放は必須
regfree&regst

# 最大取り扱い桁数 9999無量大数10^68までの数
if strlenargv[1] > 4 + 68 + 1 
puts "%s は 長すぎます。73桁までの数字を入力して下さい。", argv[1]
exit1


# 漢数字への変換処理
# 4桁ごとに漢数字に変換する
# 例1234567890
# => 十二 億 三千四百五十六 万 七千八百九拾

# 変数宣言
digit_length # 何桁の数字か
i, u
char string_number[4 + 68 + 1 + 1] # 算用数字 最大取り扱い桁数
# 9999無量大数9999*1e68まで
strcpystring_number, ""# 初期化
# 変換後の漢数字4桁毎に7文字21バイトになるので また万億兆などの文字数も追加
char chinese_numeral[7 * 3 * 72 / 4 + sizeofunit2 + 1]
strcpychinese_numeral, ""
char work[7 * 3 + 1]
strcpywork, ""

# 4桁ごとに区切って渡せるよう、先頭に0を付与する
# 12 3456 7890 => 0012 3456 7890
digit_length = strlenargv[1] # 何桁の数であるか？
giving_zero = 4 - digit_length % 4 # 先頭に付与すべき0の数
if giving_zero == 4 
giving_zero = 0

for i = 0 i < giving_zero i++ 
strcatstring_number, "0"

strcatstring_number, argv[1]

# 何桁の数字か
digit_length = strlenstring_number

# ４桁毎に漢数字に変換
# 4桁までなら unit2 ""# 8桁までなら unit2 "万"# 12桁までなら unit2 "億"
# を付与する
unit2_index = digit_length / 4 - 1
for u = 0 u < digit_length / 4 u++, unit2_index-- 
# string_number から 各ユニット毎に、4文字ずつ work にコピー
work[0] = string_number[4 * u + 0]
work[1] = string_number[4 * u + 1]
work[2] = string_number[4 * u + 2]
work[3] = string_number[4 * u + 3]
work[4] = ''

# 4桁毎に漢数字に変換、結果を連結する
strcatchinese_numeral, num2kanwork
# ・・・ "兆", "億", "万", "" の付与
strcatchinese_numeral, unit2[unit2_index]


# 0 の場合のみ、空文字列のままなので、"〇" にする。
if strlenchinese_numeral == 0 
strcpychinese_numeral, digit[0]


# 結果表示
puts "%s", chinese_numeral



# 4桁 の 漢数字へ変換する関数
char *num2kanchar *str 
# 変数宣言
i
char work[7 * 3 + 1] # 三千四百五十六 7文字*3バイト+終端文字1バイト
strcpywork, "" # 初期化

# 一つずつ漢数字に変換する
for i = 0 i < 4 i++ 
switch str[i] 
case '0':
break # 何もせず、次の桁へ進む
case '1':
# 一の位のみ "一"と書く
if i == 3 
strcatwork, digit[str[i] - '0'] # str[i]-'0' 文字0から数値0へ変換

strcatwork, unit1[i] # "千", "百", "十", "" のいずれか
break
default:
strcatwork, digit[str[i] - '0'] # "一" 〜 "九"
strcatwork, unit1[i] # "千", "百", "十", "" のいずれか
break



# 作業結果を戻す
return strcpystr, work



# 入力を促すメッセージ表示
puts "何年生まれですか? 例: S30 >"

# 8文字までキーボードから入力を受け取れるよう、バッファを用意
char buffer[8]

# キーボードから一行読み込む
# scanfはいろいろ支障があるので、
# fgets関数で、bufferへ、sizeofbuffer-1文字分7文字分,
# stdin=キーボードから読み込む
if fgetsbuffer, sizeofbuffer, stdin == NULL 
# エラーメッセージ出力
puts "キーボードから読み込めませんでした。"
exit1


# 改行文字が含まれているかどうか？
if strchrbuffer, '' != NULL 
# S30エンター のように4文字タイプされたときは、
# 改行文字（エンター）を文字列の終端記号に置換する
buffer[strlenbuffer - 1] = '\0'
 else 
# buffer内に、改行文字が含まれていない場合（＝8文字以上続けてタイプされた場合）
# 最初の7文字は読み込まれているので、残りの入力ストリーム（キーバッファ）をクリアする
while getchar != ''



# 読み込めているか、確認
# puts "キーボードからの入力は、%s です。", buffer

# 入力文字列の先頭が、M, T, S, H で始まっているか確認し、西暦年に変換する
year # 西暦年
char era_initial # 明治: 'M', 大正: 'T', 昭和: 'S', 平成: 'H'
char era_year[3] # 元号で何年か

# S30 と入力されていた場合、
# S をera_initialにセットする
era_initial = buffer[0]
# 30 をera_yearにセットする
era_year[0] = buffer[1]
era_year[1] = buffer[2]
era_year[2] = '\0'

char *endptr # 数値に変換出来なかった文字
# atoi関数は、文字列を数値に変換出来なかった場合にでも、0を返します。
# 本当に、"0" という文字列が、0 という数値に変換されたのか、
# 区別が出来ないので、strtol関数を使います。
year = strtolera_year, &endptr, 10 # 10進数として変換する

# 数値変換不可の文字列の長さを調べる。
if strlenendptr != 0 
# エラーメッセージ出力
puts "%s は、元号年として認識出来ませんでした。", endptr
exit1


switch era_initial 
case 'M':
year += 1867
break
case 'T':
year += 1911
break
case 'S':
year += 1925
break
case 'H':
year += 1988
break
default:
# エラーメッセージ出力
puts "%c は、元号の文字として認識出来ませんでした。", era_initial
exit1


# 干支の算出方法は、前回と同様
# 干支の配列 12で割り切れる年は申年
char *eto[] = "申", "酉", "戌", "亥", "子", "丑",
 "寅", "卯", "辰", "巳", "午", "未"
puts "%c%s年%d年生まれのあなたの干支は、%s です。", era_initial,
 era_year, year, eto[year % 12]



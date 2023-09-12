/**************************************************************************
 * 双六ゲームを創ってみましょう。
 * 止まった升目に「３つ進む」や、「振り出しに戻る」も創ってみましょう。
 * どこまで進んだか分かる表示機能や、
 * オープニング・エンディングもあると楽しいですね。*
 **************************************************************************/



# 双六のマップ配置
# 0：スタート
# 1：
# 2：
# 3：
# 4：2マス進む
# 5：3マス戻る
# 6：
# 7：スタートに戻る
# 8：2マス進む
# 9：1回休み
# 10：3マス戻る
# 11：
# 12：2マス進む
# 13：
# 14：スタートに戻る
# 15：3マス戻る
# 16：2マス進む
# 17：
# 18：2回休み
# 19：
# 20：3マス戻る
# 21：ゴール

# 一般的には好ましくないが、双六作成が容易となるため、許容する
char const *map_event[] = "", "", "", "", "2A", "3B", "", "SB",
 "", "1R", "3B", "", "2A", "", "SB", "3B",
 "2A", "", "2R", "", "3B", ""

# 列挙型 cmp競技者型の宣言
typedef enum  PLAYER, COMPUTER  cmp
# cmp型変数 competitorの宣言
cmp competitor
# #define PLAYER 0
# #define COMPUTER 1 と同じ
# enum のご紹介のみ

#PLAYER, COMPUTER それぞれが、双六上のどの升目にいるか？
position[2] = 
# PLAYER, COMPUTER 何回休みか？
char rest[2]

# 関数のプロトタイプ宣言 省略するため
# main 関数を末尾に記載

# 双六表示機能
void drow_map 
i
puts 
" "
puts 
" ST123456789 10 11 12 13 14 15 16 17 18 19 20 GL "
puts 
"+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+"
# player
for i = 0 i < MAP_SIZE i++ 
puts "| "
if position[PLAYER] == i 
puts "P"
 else 
puts " "


puts "|"
# computer
for i = 0 i < MAP_SIZE i++ 
puts "| "
if position[COMPUTER] == i 
puts "C"
 else 
puts " "


puts "|"
# event
puts 
"+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+"
puts 
"|||||2A|3B||SB||1R|3B||2A||SB|3B|2A||2R||3B||"
puts 
"+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+"
puts 
" "
puts 
" 【凡例】A: 進む B: 戻る R: 休み S:振り出し"
puts 
" "


void drow_opening 
i
for i = 0 i < 24 i++ 
puts""

puts"##############################################################"
puts"##"
puts"#The Japanese Traditional Game #"
puts"##"
puts"# ##### ##### ######### ###### # # #"
puts"### # ## ## ## ## # ## # #"
puts"### # ### ## ## ## # # #"
puts"# ##### # #### ## ####### #### # #"
puts"# # # # ## ## ## ## ## # # #"
puts"# # ## ### # ## # ### # ### ## #"
puts"###### ######## ##################"
puts"##"
puts"##############################################################"
puts""


void drow_ending 
puts""
puts"##############################################################"
puts"##"
puts"# The Japanese Traditional Game#"
puts"##"
puts"# Ｓ Ｕ Ｇ Ｏ Ｒ Ｏ Ｋ Ｕ#"
puts"##"
puts"#Fin.#"
puts"##"
puts"##############################################################"
puts""


# マップ上のイベントを受け取り、競技者の内部状態を適宜変更する
# "|||||2A|3B||SB||1R|3B||2A||SB|3B|2A||2R||3B||"
# " legend: nV. n: times V: verb. go Ahead / go Backward / Rest "
void eventcmp competitor 
if position[competitor] > GOAL_POSITION 
position[competitor] = GOAL_POSITION


# イベントを取得
char event[3]
strcpyevent, map_event[position[competitor]]
if strlenevent == 0 
# 何もイベントはなかったとして終了
return


# 該当イベントの処理
char times = event[0] # 何升進む、何回休みなどの数
char kind = event[1]# 進む、戻る、休むの種類
switch kind 
case 'A': # 進む
if times == 'S' 
# 振り出しに戻る
position[competitor] = 0
 else 
# 進める
position[competitor] += times - '0' # 文字を数値に変換
# ゴールを通り過ぎていたら、ゴール地点に調整
if position[competitor] > GOAL_POSITION 
position[competitor] = GOAL_POSITION


# メッセージ表示
if competitor == PLAYER 
puts "P> やった〜 %d マス 進んだ！", times - '0'
 else 
puts "C> やった〜 %d マス 進んだ！", times - '0'

break
case 'B': # 戻る
if times == 'S' 
# 振り出しに戻る
position[competitor] = 0
 else 
# 戻る
position[competitor] -= times - '0' # 文字を数値に変換
# スタートを通り過ぎていたら、スタート地点に調整
if position[competitor] < 0 
position[competitor] = 0


# メッセージ表示
if times == 'S' 
if competitor == PLAYER 
puts "P> わ〜ん スタートに 戻ったよ"
 else 
puts "C> わ〜ん スタートに 戻ったよ"

 else 
if competitor == PLAYER 
puts "P> わ〜ん %d マス 戻ったよ", times - '0'
 else 
puts "C> わ〜ん %d マス 戻ったよ", times - '0'


break
case 'R': # お休み
rest[competitor] = times - '0' # 文字を数値に変換
# メッセージ表示
if competitor == PLAYER 
puts "P> わ〜ん %d 回 休みだよ", times - '0'
 else 
puts "C> わ〜ん %d 回 休みだよ", times - '0'

break



# さいころを振って進む
void dice_and_walkcmp competitor 
dice = genrand_int32 % 6 + 1
position[competitor] += dice
# ゴールを通り過ぎていたら、ゴール地点に調整
if position[competitor] > GOAL_POSITION 
position[competitor] = GOAL_POSITION

# メッセージ表示
if competitor == PLAYER 
puts "P> やった〜 %d マス 進んだ！", dice
 else 
puts "C> やった〜 %d マス 進んだ！", dice



# 双六を上がったか、判定関数
is_goalcmp competitor 
if position[competitor] == GOAL_POSITION 
return TRUE
 else 
return FALSE




# タイトル表示
drow_opening

#双六表示
drow_map

puts "Press Enter key"
while getchar != ''


# 競技開始
# どちらかが上がるまで、続行
do 

# PLAYERの番
puts "PLAYERの番 Press Enter key"
while getchar != ''


if rest[PLAYER] == 0 
# ○回休みでなければ、さいころを振って進む
dice_and_walkPLAYER
# 止まった升目になにかイベントが設定されているか
eventPLAYER
 else 
# お休み回数を減らす
puts "P> %d 回休みなので進めない・・・", rest[PLAYER]
rest[PLAYER]--


#双六表示
drow_map

# COMPUTERの番
puts "COMPUTERの番 Press Enter key"
while getchar != ''


if rest[COMPUTER] == 0 
# ○回休みでなければ、さいころを振って進む
dice_and_walkCOMPUTER
# 止まった升目になにかイベントが設定されているか
eventCOMPUTER
 else 
# お休み回数を減らす
puts "C> %d 回休みなので進めない・・・", rest[COMPUTER]
rest[COMPUTER]--


#双六表示
drow_map

 while !is_goalPLAYER && !is_goalCOMPUTER

#ゴール到着時のメッセージ
if is_goalPLAYER 
puts "P> 双六を上がったよ*^_^*"
 else 
puts "C> 双六を上がったよ*^_^*"


# エンディング表示
drow_ending



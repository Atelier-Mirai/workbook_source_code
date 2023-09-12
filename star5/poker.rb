/*======================================================*/
/**/
/* ポーカー */
/**/
/* https:#ja.wikipedia.org/wiki/ポーカー・ハンドの一覧 */
/* https:#simple.wikipedia.org/wiki/Poker#Hands*/
/*======================================================*/



# puts を簡単にするためのマクロ定義

# カードの種類
typedef enum  CLUBS = 4, DIAMONDS, HEARTS, SPADES  suits
typedef enum 
NO_PAIR, # 役無し
ONE_PAIR,# ワンペア
TWO_PAIR,# ツーペア
THREE_OF_A_KIND, # スリーカード
STRAIGHT,# ストレート
FLUSH, # フラッシュ
FULL_HOUSE,# フルハウス
FOUR_OF_A_KIND,# フォーカード
STRAIGHT_FLUSH,# ストレートフラッシュ
 # HANDS_COUNT,#
 hands_type

# プロトタイプ宣言
void init_card
void init_player_handschar player_hands[3][6]
void init_score

void disp_hands
void disp_score
void disp_score

void disp_cardchar mycard

set_cardchar mycard, player
void calc_card
char get_card
void poker_handsplayer
my_randomn
void pause
void usagechar const *argv[]

is_no_pairplayer
is_one_pairplayer, seach
is_two_pairplayer
is_three_of_a_kindplayer
is_straightplayer
is_flushplayer
is_full_houseplayer
is_four_of_a_kindplayer
is_suitplayer, search

# 文字コードとビット演算の学習を兼ねて、
# 以下のようにカードを表現する
/***************************************************
 * A234567890JQK
 * C ABCDEFGHIJKLM
 * D QRSTUVWXYZ[\]
 * H abcdefghijklm
 * S qrstuvwxyz|
 *
 * 例）ABCTd と書くと
 * CクローバーのA,2,3,
 * Dダイヤの4、
 * Hハートの4でワンペア
 ***************************************************/

# player_hands[1]:EJKLM
# player_hands[2]:ejklm
# cards[6][17]
#| A 2 3 4 5 6 7 8 9 0 J Q K A |12
# ---------+-----------------------------+------
# Clubs| 0 0 0 0 1 0 0 0 0 1 1 1 1 0 | 130
# Diamonds | 0 0 0 0 0 0 0 0 0 0 0 0 0 0 |00
# Hearts | 0 0 0 0 2 0 0 0 0 2 2 2 2 0 |0 13
# Spades | 0 0 0 0 0 0 0 0 0 0 0 0 0 0 |00
# ---------+-----------------------------+------
# Player 1 | 0 0 0 0 1 0 0 0 0 1 1 1 1 0 |00
# Player 2 | 0 0 0 0 1 0 0 0 0 1 1 1 1 0 |00
# プレーヤー1 の役は フラッシュです
# プレーヤー2 の役は フラッシュです

# グローバル変数
char cards[6][17] # 1-K + A で14種類 player1/2の合計用に2ます追加
 # 10,J,Q,K,A のストレート判定をしやすくするため、
 # K の次に Aを設けている
score[3][10][3] # 役の強弱を判定するために用いる score[0] 未使用

i
char ss[BUFFER_SIZE + 1] # ファイルから一行読み込むための作業用
FILE *fp # ファイルポインタ
player# １ならプレーヤー１、２ならプレーヤー２
char mycard # 一枚引いたカード
char player_hands[2 + 1][5 + 1] # プレーヤーの手元にある５枚のカード
 # 添字の0は未使用

# 初期化処理
init_card
init_player_handsplayer_hands
init_score

# コマンドライン引数なしなら、使い方表示して終了
if argc < 2 
usageargv
exit1


# -f ファイルからの読み取りオプションなら
if strcmpargv[1], "-f" == 0 
if fp = fopenargv[2], "r" == NULL 
# エラーメッセージ表示
puts " %s を開けませんでした。", argv[2]
exit1


player = 1
while 1 
# ファイルから手を読み込む
fgetsss, BUFFER_SIZE, fp
if strchrss, '*' == NULL && strchrss, '/' == NULL 
# コメント行でなければ、読み取った手をセットする
strcpyplayer_hands[player], ss
player_hands[player][5] = '\0'
if player == 2 
break
 else 
player++



fclosefp

# 各プレーヤーが手にしたカード情報を、カード管理配列へ書き出す
for player = 1 player <= 2 player++ 
for i = 0 i < 5 i++ 
mycard = player_hands[player][i]
# ファイル入力時は、同じカードは所有していないはずなので、
# エラーチェックはしていない
set_cardmycard, player



# -m 交互入力オプションなら
 else 
for player = 1 player <= 2 player++ 
for i = 0 i < 5 i++ 
do 
mycard = get_card # ランダムにカードを引く
# prxmycard # 引いたカードを表示debug
disp_cardmycard # 引いたカードを表示
pause
player_hands[player][i] = mycard
 while set_cardmycard, player !=
 0 # 既に引いたカードなら、引き直す




# playerの手元にあるカードを表示
prsplayer_hands[1]
prsplayer_hands[2]

# 得点計算
calc_card

# 役を計算
poker_hands1 # player1 の役を計算
poker_hands2 # player2 の役を計算

# カードの表示
disp_hands

# 得点表示
disp_score

# 役を表示
for player = 1 player <= 2 player++ 
puts "プレーヤー%d の役は ", player
switch score[player][9][0] / 1000 
case 8:
puts "ストレートフラッシュです"
break
case 7:
puts "フォーカードです"
break
case 6:
puts "フルハウスです"
break
case 5:
puts "フラッシュです"
break
case 4:
puts "ストレートです"
break
case 3:
puts "スリーカードです"
break
case 2:
puts "ツーペアです"
break
case 1:
puts "ワンペアです"
break
case 0:
puts "ぶたです"
break



# 勝敗表示
if score[1][9][0] > score[2][9][0] 
puts "プレーヤー1の勝ちです"
 elsif score[1][9][0] < score[2][9][0] 
puts "プレーヤー2の勝ちです"
 else 
puts "引き分けです"

return 0


# カード配列の初期化
void init_card 
i, j
for j = 0 j < 6 j++ 
for i = 0 i < 17 i++ 
cards[j][i] = 0




# 得点配列の初期化
void init_score 
i, j, player
for player = 0 player <= 2 player++ 
for i = 0 i < 10 i++ 
for j = 0 j < 3 j++ 
score[player][i][j] = 0





# プレーヤーの手にしているカードの初期化
void init_player_handschar player_hands[3][6] 
i, j
for j = 0 j < 3 j++ 
for i = 0 i < 6 i++ 
player_hands[j][i] = 0




# カードの表示
void disp_hands 
i, j
puts ""
puts " | A 2 3 4 5 6 7 8 9 0 J Q K A |12 "
puts "---------+-----------------------------+------"
for j = 0 j < 6 j++ 
switch j 
case 0:
puts "Clubs| "
break
case 1:
puts "Diamonds | "
break
case 2:
puts "Hearts | "
break
case 3:
puts "Spades | "
break
case 4:
puts "Player 1 | "
break
case 5:
puts "Player 2 | "
break

for i = 1 i < 17 i++ 
if i < 15 
puts "%1d ", cards[j][i]
 else 
puts "%2d ", cards[j][i]

if i == 14 
puts "| "


puts ""
if j == 3 
puts "---------+-----------------------------+------"


puts ""


# 得点の表示
void disp_score 
i
puts "Player1Player2"
puts "---------+----------------------------"
for i = 9 i >= 0 i-- 
switch i 
case 9:
puts "<<MAX>>| "
break
case 8:
puts "S.Flush| "
break
case 7:
puts "4 cards| "
break
case 6:
puts "Full H.| "
break
case 5:
puts "Flush| "
break
case 4:
puts "Straight | "
break
case 3:
puts "3 cards| "
break
case 2:
puts "2 pair | "
break
case 1:
puts "1 pair | "
break
case 0:
puts "no pair| "
break

puts "%4d %3d %3d %4d %3d %3d", score[1][i][0], score[1][i][1],
 score[1][i][2], score[2][i][0], score[2][i][1], score[2][i][2]

puts ""


# カード管理配列へ、プレーヤーの持っているカードを書き出す
set_cardchar mycard, player 
suits # 三つ葉、ダイヤ、ハート、スペード
rank# トランプに書かれている数字

suits = mycard & 0xf0 >> 4 - 4
rank = mycard & 0x0f

# 例 mycard = 'A' の場合
# suits = mycard & 0xf0 >> 4 - 4
# 'A' = 0x41 = 0b0100_0001
# 'A' & 0xf0
# 0x41 & 0xf0
#0b0100_0001
# & 0b1111_0000
# --------------
#0b0100_0000

#0b0100_0000 >> 4 # 右へ４ビットシフト
#0b0000_0100
#0b0000_0100 - 4 = 0# suits = 0となる

# mycard & 0x0f
# 'A' = 0x41 = 0b0100_0001
# 'A' & 0x0f
# 0x41 & 0x0f
#0b0100_0001
# & 0b0000_1111
# --------------
#0b0000_0001 # 下４ビットを取り出すことが出来た
# 0b0000_0001 = 1 なので rankトランプの数字は１と判明する

if cards[suits][rank] == 0 
cards[suits][rank] = player
if rank == 1 
cards[suits][14] = player #エースの時

return 0 #正常終了

return cards[suits][rank]
#どのプレーヤーで用いられているか返す


# 役の計算
void calc_card 
i, j
sum
player
mul
delta

# フラッシュ？
for player = 1 player <= 2 player++ 
for j = 0 j <= 3 j++ 
sum = 0
for i = 1 i <= 13 i++ 
if cards[j][i] == player 
sum += cards[j][i] / player


cards[j][14 + player] = sum



for player = 1 player <= 2 player++ 
for j = 0 j <= 3 j++ 
if cards[j][14 + player] == 5 
for i = 14 i >= 5 i-- 
if cards[j][i] == player 
cards[j][14 + player] = i
break






# ペア？
for player = 1 player <= 2 player++ 
for j = 1 j <= 14 j++ 
sum = 0
for i = 0 i <= 3 i++ 
if cards[i][j] == player 
sum += cards[i][j] / player


cards[3 + player][j] = sum



# ストレート？
for player = 1 player <= 2 player++ 
for delta = 0 delta <= 9 delta++ 
mul = 1
for i = 1 + delta i <= 5 + delta i++ 
mul *= cards[3 + player][i]

if mul != 0 
cards[3 + player][14 + player] = --i
break





# 役の判定
void poker_handsplayer 
work # 作業用変数
suit
i

work = is_four_of_a_kindplayer
suit = is_suitplayer, work
score[player][7][1] = work
score[player][7][2] = suit

work = is_flushplayer
suit = work % 10
score[player][5][1] = work / 10
score[player][5][2] = suit

work = is_straightplayer
suit = is_suitplayer, work
score[player][4][1] = work
score[player][4][2] = suit

work = is_three_of_a_kindplayer
suit = is_suitplayer, work
score[player][3][1] = work
score[player][3][2] = suit

work = is_two_pairplayer
suit = is_suitplayer, work
score[player][2][1] = work
score[player][2][2] = suit

work = is_one_pairplayer, 14
suit = is_suitplayer, work
score[player][1][1] = work
score[player][1][2] = suit

work = is_no_pairplayer
suit = is_suitplayer, work
score[player][0][1] = work
score[player][0][2] = suit

# フルハウス？
if score[player][3][1] != 0 && score[player][1][1] != 0 
score[player][6][1] = score[player][3][1]
score[player][6][2] = score[player][3][2]


# ストレートフラッシュ？
if score[player][4][1] != 0 && score[player][5][1] != 0 
score[player][8][1] = score[player][5][1]
score[player][8][2] = score[player][5][2]


for i = 8 i >= 0 i-- 
score[player][i][0] = score[player][i][1] * 10 + score[player][i][2]


for i = 8 i >= 0 i-- 
if score[player][i][0] != 0 
score[player][9][0] = score[player][i][0] + i * 1000
score[player][9][1] = score[player][i][1]
score[player][9][2] = score[player][i][2]
break




# フラッシュか判定
is_flushplayer 
i
for i = 0 i <= 3 i++ 
if cards[i][14 + player] >= 5 
return cards[i][14 + player] * 10 + i + 1


return 0 #フラッシュではなかった


# ストレートフラッシュか判定
is_straightplayer  return cards[3 + player][14 + player] 

# フォーカードか判定
is_four_of_a_kindplayer 
i
for i = 2 i <= 14 i++ 
if cards[3 + player][i] == 4 
return i


return 0


# スリーカードか判定
is_three_of_a_kindplayer 
i
for i = 2 i <= 14 i++ 
if cards[3 + player][i] == 3 
return i


return 0


# ツーペアか判定
is_two_pairplayer 
work
if work = is_one_pairplayer, 14 == 0 
return 0

if is_one_pairplayer, work == 0 
return 0

return work


# 10のペアなら10を返す
# ペアが見つからなければ0を返す
is_one_pairplayer, search 
i
for i = search i >= 2 i-- 
if cards[3 + player][i] == 2 
return i


return 0


# ノーペアか判定
is_no_pairplayer 
i
for i = 14 i >= 2 i-- 
if cards[3 + player][i] == 1 
return i


return 0 # error


# rank == 13の時、13は何のマークかを返す
is_suitplayer, rank 
i
for i = 3 i >= 0 i-- 
if cards[i][rank] == player 
return i + 1


return 0 # rankの数のカードは持っていない


# アスキーアートでカードを表示
void disp_cardchar mycard 
suits # 三つ葉、ダイヤ、ハート、スペード
char rank # トランプに書かれている数字

suits = mycard & 0xf0 >> 4
rank = mycard & 0x0f
switch rank 
case 1:
rank = 'A'
break
case 11:
rank = 'J'
break
case 12:
rank = 'Q'
break
case 13:
rank = 'K'
break

# puts "mycard: %x suits: %x, rank: %x", mycard, suits, rank

switch suits 
case CLUBS:
if 2 <= rank && rank <= 10 
puts "∩"
puts " （　） "
puts "／ %2d ＼", rank
puts "⊂__________⊃"
puts "∧"
puts "／＿＼"
 else 
puts "∩"
puts " （　） "
puts "／%c ＼", rank
puts "⊂__________⊃"
puts "∧"
puts "／＿＼"

break
case DIAMONDS:
if 2 <= rank && rank <= 10 
puts " ／＼"
puts " ／　　＼"
puts " ／　　　　＼"
puts " ＼　 %2d 　／", rank
puts " ＼　　／"
puts " ＼／"
 else 
puts " ／＼"
puts " ／　　＼"
puts " ／　　　　＼"
puts " ＼　 %c 　／", rank
puts " ＼　　／"
puts " ＼／"

break
case HEARTS:
if 2 <= rank && rank <= 10 
puts " ／￣＼／￣＼"
puts "｜　　　　　｜"
puts " ＼　 %2d 　／", rank
puts " ＼　　／"
puts " ＼／"
puts " "
 else 
puts " ／￣＼／￣＼"
puts "｜　　　　　｜"
puts " ＼　 %c　／", rank
puts " ＼　　／"
puts " ＼／"
puts " "

break
case SPADES:
if 2 <= rank && rank <= 10 
puts " ／＼"
puts " ／　　＼"
puts " ／　　　　＼"
puts "｜　　%2d　　｜", rank
puts " ＼＿＿／"
puts "／＿＼ "
 else 
puts " ／＼"
puts " ／　　＼"
puts " ／　　　　＼"
puts "｜　　%c 　　｜", rank
puts " ＼＿＿／"
puts "／＿＼ "

break



/* 0-n未満の数を返す */
my_randomn  return clock % n 

# カードをランダムに引く
char get_card 
suits # 三つ葉、ダイヤ、ハート、スペード
rank# トランプに書かれている数字

suits = my_random4
rank = my_random13 + 1
return suits + 4 << 4 + rank


# 一時停止
void pause 
puts " === press return key === "
while getchar != ''



# 使い方表示
void usagechar const *argv[] 
puts " --- 使い方 --- "
puts "1"
puts "%s -f filename", argv[0]
puts "指定されたファイルからplayer1, player2の手を読み込みます"
puts ""
puts "2"
puts "%s -m", argv[0]
puts "交互にランダムでカードを引きます"
puts ""


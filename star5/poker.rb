#==============================================================================
#
# ポーカー
#
# https://ja.wikipedia.org/wiki/ポーカー
# https://ja.wikipedia.org/wiki/ポーカー・ハンドの一覧
#
# 文字コードとビット演算の学習を兼ねて、次のようにカードを表現します。
#
# ASCIIコード表抜粋
#|123456789ABCD
# -----+-------------
# 0x40 |ABCDEFGHIJKLM
# 0x50 |QRSTUVWXYZ[\]
# 0x60 |abcdefghijklm
# 0x70 |qrstuvwxyz|
#
# 文字'A'の文字コードは0x41です。
# 上位4bitでカードの種類suits を、
# 下位4bitでカードの数字rankを、表現することとします。
# するとトランプカード一式は次のように表現できます。
#
# カードの表現
#|A234567890JQK
# ---------+-------------
# ♣️Club |ABCDEFGHIJKLM
# ♦︎Diamond|QRSTUVWXYZ[\]
# ♡Heart|abcdefghijklm
# ♠️Spade|qrstuvwxyz|
#
# 例）Cards と書くと
# Cは Club三つ葉の3
# aは HeartハートのA
# rは Spadeスペードの2
# dは Heartハートの4
# sは Spadeスペードの3 を表すので
# ワンペアとなります。
#
# プレイヤーの手札は文字型の配列で表現します。
# $hands[1]:EJKLM
# $hands[2]:ejklm
#
# また、役の判定を行いやすくするために、次のような管理配列を用意します。
# $cards[6][17]
#| A 2 3 4 5 6 7 8 9 0 J Q K A | P1 P2
# ---------+-----------------------------+------
# Clubs| 0 0 0 0 1 0 0 0 0 1 1 1 1 0 |50
# Diamonds | 0 0 0 0 0 0 0 0 0 0 0 0 0 0 |00
# Hearts | 0 0 0 0 2 0 0 0 0 2 2 2 2 0 |05
# Spades | 0 0 0 0 0 0 0 0 0 0 0 0 0 0 |00
# ---------+-----------------------------+------
# Player 1 | 0 0 0 0 1 0 0 0 0 1 1 1 1 0 |00
# Player 2 | 0 0 0 0 1 0 0 0 0 1 1 1 1 0 |00
#
# この場合、プレーヤー1は三つ葉を5枚、プレーヤー2はハートを5枚持っています。
# ですので、どちらの役もフラッシュです。
#==============================================================================

# カードの種類
CLUBS    = 4
DIAMONDS = 5
HEARTS   = 6
SPADES   = 7

# 役の種類
NO_PAIR         = 0 # ぶた
ONE_PAIR        = 1 # ワンペア
TWO_PAIR        = 2 # ツーペア
THREE_OF_A_KIND = 3 # スリーカード
STRAIGHT        = 4 # ストレート
FLUSH           = 5 # フラッシュ
FULL_HOUSE      = 6 # フルハウス
FOUR_OF_A_KIND  = 7 # フォーカード
STRAIGHT_FLUSH  = 8 # ストレートフラッシュ
TOTAL_SCORE     = 9 # 役判定後の合計得点

# 役の名称
HANDS_NAME = ["ぶた",
              "ワンペア",
              "ツーペア",
              "スリーカード",
              "ストレート",
              "フラッシュ",
              "フルハウス",
              "フォーカード",
              "ストレートフラッシュ"]

# 変数名の先頭に $ をつけるとグローバル変数になります。
# プログラム中のどこからでもアクセスできます。

# カード管理用配列
# 10,J,Q,K,A のストレート判定の為
# K の次にも Aを設けることで、14要素
# Player1, 2の合計用に 2要素追加し
# 添字0は未使用の為、17要素とする
$cards = Array.new(4+2) do
          Array.new(14+2+1) { 0 }
        end
        # =>
        # [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        #  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        #  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        #  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        #  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        #  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

# プレーヤーの手元にある5枚のカードを保持する配列
# 添字の0は未使用
$hands = ["", "", ""]

# 役を点数に変換、強弱を判定するために用いる配列
# 添字の0は未使用
$scores = Array.new(2+1) do
          Array.new(9+1) do
            Array.new(2+1) { 0 }
          end
        end

# カードの表示
#------------------------------------------------------------------------------
def disp_cards
      printf "\n"
      printf "         | A 2 3 4 5 6 7 8 9 0 J Q K A | P1 P2\n"
      printf "---------+-----------------------------+------\n"
  (0...6).each do |suit|
    case suit
    when 0
      printf "Clubs    | "
    when 1
      printf "Diamonds | "
    when 2
      printf "Hearts   | "
    when 3
      printf "Spades   | "
    when 4
      printf "Player 1 | "
    when 5
      printf "Player 2 | "
    end

    (1...17).each do |rank|
      printf "%1d ", $cards[suit][rank]
      if rank == 14
        printf "| "
      end
    end
    printf "\n"
    if suit == 3
      puts "---------+-----------------------------+------"
    end
  end
  puts ""
end

# 得点の表示
#------------------------------------------------------------------------------
def disp_scores
  printf "               Player1              Player2     \n"
  printf "            Score suit rank      Score suit rank\n"
  printf "---------+--------------------------------------\n"
  TOTAL_SCORE.downto NO_PAIR do |hand|
    case hand
    when TOTAL_SCORE
      printf "= TOTAL =| "
    when STRAIGHT_FLUSH
      printf "S.Flush  | "
    when FOUR_OF_A_KIND
      printf "4 cards  | "
    when FULL_HOUSE
      printf "Full H.  | "
    when FLUSH
      printf "Flush    | "
    when STRAIGHT
      printf "Straight | "
    when THREE_OF_A_KIND
      printf "3 cards  | "
    when TWO_PAIR
      printf "2 pair   | "
    when ONE_PAIR
      printf "1 pair   | "
    when NO_PAIR
      printf "no pair  | "
    end
    printf("%5d %5d %5d   %5d %5d %5d\n",
           $scores[1][hand][0], $scores[1][hand][2], $scores[1][hand][1],
           $scores[2][hand][0], $scores[2][hand][2], $scores[2][hand][1]);
  end
  printf "\n"
end

# アスキーアートでカードを表示
#------------------------------------------------------------------------------
def draw_ascii_art(mycard)
  # suit 三つ葉、ダイヤ、ハート、スペード
  # rank トランプに書かれている数字
  suit = (mycard & 0xf0) >> 4
  rank = (mycard & 0x0f)

  rank = case rank
         when  1 then 'A '
         when 11 then 'J '
         when 12 then 'Q '
         when 13 then 'K '
         else rank
         end

  fmt  = rank.kind_of?(Integer) ? "%2d" : "%c"

  case suit
  when CLUBS
    printf "      ∩      \n"
    printf "    （　）    \n"
    printf "   ／ #{fmt} ＼  \n", rank
    printf "⊂__________⊃\n"
    printf "      ∧      \n"
    printf "    ／＿＼    \n"
  when DIAMONDS
    printf "     ／＼     \n"
    printf "   ／　　＼   \n"
    printf " ／　 #{fmt}　 ＼\n", rank
    printf " ＼　     　／\n"
    printf "   ＼　　／   \n"
    printf "     ＼／     \n"
  when HEARTS
    printf " ／￣＼／￣＼ \n"
    printf "｜　　　　　｜\n"
    printf "｜　  #{fmt}  　｜\n", rank
    printf " ＼　     　／\n"
    printf "   ＼　　／   \n"
    printf "     ＼／     \n"
  when SPADES
    printf "     ／＼      \n"
    printf "   ／　　＼    \n"
    printf " ／　 #{fmt} 　＼  \n", rank
    printf "｜　　  　　｜\n"
    printf " ＼＿    ＿／  \n"
    printf "    ／＿＼     \n"
  end
end

# カード管理配列へ、プレーヤーの持っているカードをセットする
#------------------------------------------------------------------------------
def set_card(mycard, player)
  mycard = mycard.ord # 文字コードに変換

  # suit 三つ葉、ダイヤ、ハート、スペード
  # rank トランプに書かれている数字
  suit = ((mycard & 0xf0) >> 4) - 4
  rank =  (mycard & 0x0f)

  # 例 mycard = 'A' の場合
  # suits = ((mycard & 0xf0) >> 4) - 4
  # 'A' = 0x41 = 0b0100_0001
  # 'A' & 0xf0
  # 0x41 & 0xf0
  #   0b0100_0001
  # & 0b1111_0000
  # --------------
  #   0b0100_0000

  #   0b0100_0000 >> 4 # 右へ４ビットシフト
  #   0b0000_0100
  #   0b0000_0100 - 4 = 0 # suits = 0となる

  # mycard & 0x0f
  # 'A' = 0x41 = 0b0100_0001
  # 'A' & 0x0f
  # 0x41 & 0x0f
  #   0b0100_0001
  # & 0b0000_1111
  # --------------
  #   0b0000_0001 # 下４ビットを取り出すことが出来た
  #   0b0000_0001 = 1 なので rankトランプの数字は１と判明する

  # まだどのプレーヤーの手札にもなっていなければ
  if $cards[suit][rank] == 0
    # playerの手札になっている旨、セットする
    $cards[suit][rank] = player
    if rank == 1
      $cards[suit][14] = player #エースの時
    end
    return 0 #正常終了
  else
    # 既にいずれかのプレーヤーの手札になっているならば
    return $cards[suit][rank] #どのプレーヤーで用いられているか返す
  end
end


# cards配列内の縦横集計を行う
#          | A 2 3 4 5 6 7 8 9 0 J Q K A | P1 P2
# ---------+-----------------------------+------
# Clubs    | 0 0 0 0 0 0 0 0 0 1 1 1 1 0 |  5  0
# Diamonds | 0 0 0 0 0 0 0 0 0 0 0 0 1 0 |  0  0
# Hearts   | 2 0 0 0 0 0 0 0 0 2 2 2 2 2 |  0  5 <- Player2が5枚の
# Spades   | 0 0 0 0 0 0 0 0 0 0 0 0 0 0 |  0  0    ♡所持を示す
# ---------+-----------------------------+------
# Player 1 | 0 0 0 0 0 0 0 0 0 1 1 1 2 0 |  0  0
# Player 2 | 1 0 0 0 0 0 0 0 0 1 1 1 1 1 |  0 14 <- Player2は 14(=A)から
#                                    ^              始まるフラッシュを意味する
#                                    |___ Player1は2枚のK所持を示す
#------------------------------------------------------------------------------
def calc_cards
  # フラッシュか判定できるよう、右端集計欄に書き込む
  (1..2).each do |player|
    (0..3).each do |suit|
      $cards[suit][14 + player] = $cards[suit][1..13].count(player)
      p $cards[suit][1..13].count(player)
        # 以下と等価です。
        # sum = 0
        # (1..13).each do |rank|
        #   if $cards[suit][rank] == player
        #     sum += $cards[suit][rank] / player
        #   end
        # end
        # $cards[suit][14 + player]
    end
  end

  # フラッシュだった場合、右下隅に最高rankを書き込む
  (1..2).each do |player|
    (0..3).each do |suit|
      if $cards[suit][14 + player] == 5
        $cards[suit][14 + player] = $cards[suit][0..14].rindex(player)
        # 以下と等価です。
        # 14.downto(5).each do |rank|
        #   if $cards[suit][rank] == player
        #     card[suit][14 + player] == rank
        #     break
        #   end
        # end
      end
    end
  end

  # 1ペア〜4ペアまで判定しやすいよう、下の合計欄に書き込む
  (1..2).each do |player|
    (1..14).each do |rank|
      sum = 0
      (0..3).each do |suit|
        if $cards[suit][rank] == player
          sum += $cards[suit][rank] / player
        end
      end
      $cards[3 + player][rank] = sum
    end
  end

  # ストレートだった場合、右下隅に最高rankを書き込む
  (1..2).each do |player|
    10.downto(1).each do |rank|
      # 11111と 連続する5つの範囲の合計を取る
      if $cards[3 + player][rank..(rank+4)].count(1) == 5
        $cards[3 + player][14 + player] = rank + 4
        break
      end
    end
  end
end

# カードをランダムに引く
#------------------------------------------------------------------------------
def get_card
  # suit # 三つ葉、ダイヤ、ハート、スペード
  # rank # トランプに書かれている数字
  suit = rand(0..3)
  rank = rand(1..13)

  ((suit + 4) << 4) + rank
end

# 役が成立しているか確認し、scores配列へ結果を書き込む
#------------------------------------------------------------------------------
def calc_hands
  (1..2).each do |player|
    if rank = four_of_a_kind?(player)
      suit = get_suit player, rank
      $scores[player][FOUR_OF_A_KIND][1] = rank
      $scores[player][FOUR_OF_A_KIND][2] = suit
    end

    if rank = flush?(player)
      suit = rank % 10
      $scores[player][FLUSH][1] = rank / 10
      $scores[player][FLUSH][2] = suit
    end

    if rank = straight?(player)
      suit = get_suit player, rank
      $scores[player][STRAIGHT][1] = rank
      $scores[player][STRAIGHT][2] = suit
    end

    if rank = three_of_a_kind?(player)
      suit = get_suit player, rank
      $scores[player][THREE_OF_A_KIND][1] = rank
      $scores[player][THREE_OF_A_KIND][2] = suit
    end

    if rank = two_pair?(player)
      suit = get_suit player, rank
      $scores[player][TWO_PAIR][1] = rank
      $scores[player][TWO_PAIR][2] = suit
    end

    if rank = one_pair?(player)
      suit = get_suit player, rank
      $scores[player][ONE_PAIR][1] = rank
      $scores[player][ONE_PAIR][2] = suit
    end

    if rank = no_pair?(player)
      suit = get_suit player, rank
      $scores[player][NO_PAIR][1] = rank
      $scores[player][NO_PAIR][2] = suit
    end

    # フルハウス？
    if $scores[player][THREE_OF_A_KIND][1] != 0 && $scores[player][ONE_PAIR][1] != 0
      $scores[player][FULL_HOUSE][1] = $scores[player][THREE_OF_A_KIND][1]
      $scores[player][FULL_HOUSE][2] = $scores[player][THREE_OF_A_KIND][2]
    end

    # ストレートフラッシュ？
    if $scores[player][STRAIGHT][1] != 0 && $scores[player][FLUSH][1] != 0
      $scores[player][STRAIGHT_FLUSH][1] = $scores[player][FLUSH][1]
      $scores[player][STRAIGHT_FLUSH][2] = $scores[player][FLUSH][2]
    end

    STRAIGHT_FLUSH.downto(NO_PAIR).each do |hand|
      # 十の位はrank, 一の位はsuitとすることで、
      # 同じランクであっても、大小関係から強弱を判定できる
      # (CLUBS < DIAMONDS < HEARTS < SPADES の順に強くなる)
      $scores[player][hand][0] = $scores[player][hand][1] * 10 + $scores[player][hand][2]
    end

    STRAIGHT_FLUSH.downto(NO_PAIR).each do |hand|
      if $scores[player][hand][0] != 0
        $scores[player][TOTAL_SCORE][0] = $scores[player][hand][0] + hand * 1000
        $scores[player][TOTAL_SCORE][1] = $scores[player][hand][1]
        $scores[player][TOTAL_SCORE][2] = $scores[player][hand][2]
        break
      end
    end
  end
end

# 一時停止
#------------------------------------------------------------------------------
def pause
  printf "\n === press return key === \n"
  gets
end

# 使い方表示
#------------------------------------------------------------------------------
def usage
  puts <<~EOS
     --- 使い方 ---
    1) #{$PROGRAM_NAME} -f cards.txt
    指定されたファイル cards.txt からプレーヤーの手を読み込みます

    2) #{$PROGRAM_NAME} -m
    交互にランダムでカードを引きます
  EOS
end

# ノーペアか判定 rankを返す
#------------------------------------------------------------------------------
def no_pair?(player)
  $cards[3 + player][0..14].rindex(1)
end

# ワンペアか判定 rankを返す
#------------------------------------------------------------------------------
def one_pair?(player)
  $cards[3 + player][0..14].rindex(2)
end

# ツーペアか判定 rankを返す
#------------------------------------------------------------------------------
def two_pair?(player)
  if $cards[3 + player][2..14].count(2) == 2
    $cards[3 + player][2..14].rindex(2) + 2
  end
end

# スリーカードか判定 rankを返す
#------------------------------------------------------------------------------
def three_of_a_kind?(player)
  $cards[3 + player][0..14].rindex(3)
end

# フォーカードか判定 rankを返す
#------------------------------------------------------------------------------
def four_of_a_kind?(player)
  $cards[3 + player][0..14].rindex(4)
end

# ストレートか判定 rankを返す
#------------------------------------------------------------------------------
def straight?(player)
  # calc_cards で計算済みなので、値を返すのみ
  $cards[3 + player][14 + player] == 0 ? nil : $cards[3 + player][14 + player]
end

# フラッシュか判定
#------------------------------------------------------------------------------
def flush?(player)
  (0..3).each do |suit|
    if $cards[suit][14 + player] >= 5
      return $cards[suit][14 + player] * 10 + suit + 1
    end
  end
  nil # フラッシュではなかった
end

# 何のマークか？
# rank == 13の時、13は何のマークかを返す
#------------------------------------------------------------------------------
def get_suit(player, rank)
  3.downto(0).each do |suit|
    if $cards[suit][rank] == player
      return suit + 1
    end
  end
  0 # rankの数のカードは持っていない
end

#------------------------------------------------------------------------------
# メイン関数
#------------------------------------------------------------------------------

# コマンドライン引数無しなら、使い方表示して終了
if ARGV.size == 0
  usage
  exit
end

# -f ファイルからの読み取りオプションなら
if ARGV[0] == "-f"
  begin
    player = 1
    open(ARGV[1], "r") do |f|
      f.each_line do |line|
        line.chomp!
        if line.match?(/(\*|\/)/)
          next
        else
          # コメント行'*'や'/'を含む行でなければ、
          # 読み取った手をセットする
          $hands[player] = line.chomp
          player += 1
        end
      end
    end

    # 各プレーヤーが手にしたカード情報を、カード管理配列へ書き出す
    (1..2).each do |player| # 1ならプレーヤー1、2ならプレーヤー2を示す
      # 0枚目から4枚目までのカードを順にセットする
      $hands[player].each_char do |mycard| # 一枚場から引いたカード
        # ファイル入力時は、同じカードは所有していないはずなので、
        # エラーチェックはしていない
        set_card mycard, player
      end
    end
  # rescue
  #   puts "#{ARGV[1]}を開けませんでした。"
  #   exit 1
  end
# -m 交互入力オプションなら
else
  # getsメソッド(ARGF.getsメソッド)は、
  # コマンドラインからの引数 -m が残っていると
  # -m というファイルから読み込もうとします。
  #
  # 標準入力（キーボード）から読み込んで欲しいので、
  # コマンドラインからの引数を格納している配列 ARGV を空にします。
  # (これにより、自作した pause 一時停止 が機能するようになります)
  ARGV.shift

  (1..2).each do |player|
    # 0枚目から4枚目までのカードを場から順に引く
    (0..4).each do |n|
      loop do
        mycard = get_card # ランダムにカードを引く
        if set_card(mycard, player) == 0
          draw_ascii_art mycard # 引いたカードをアスキーアートで表示
          pause # 一時停止
          $hands[player] << mycard #手札文字列に追加
          break # 新出のカードだったので、次のカードを引く
        end
      end
    end
  end
end

# 各playerの手元にあるカードを表示
(1..2).each do |player|
  puts $hands[player]
end

# 得点計算
calc_cards

# 役を計算
calc_hands

# カード管理配列の表示
disp_cards

# 得点表示
disp_scores

# 役を表示
(1..2).each do |player|
  h = $scores[player][TOTAL_SCORE][0] / 1000
  printf "プレーヤー%d の役は %s です\n", player, HANDS_NAME[h]
end

# 勝敗表示
if $scores[1][TOTAL_SCORE][0] > $scores[2][TOTAL_SCORE][0]
  puts "プレーヤー1の勝ちです"
elsif $scores[1][TOTAL_SCORE][0] < $scores[2][TOTAL_SCORE][0]
  puts "プレーヤー2の勝ちです"
else
  puts "引き分けです"
end

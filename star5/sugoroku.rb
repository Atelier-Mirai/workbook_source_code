#==============================================================================
# 双六ゲームを創ってみましょう。
# 止まった升目に「３つ進む」や、「振り出しに戻る」も創ってみましょう。
# どこまで進んだか分かる表示機能や、
# オープニング・エンディングもあると楽しいですね。
#==============================================================================

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

# 変数名の先頭に $ をつけることにより、
# 大域変数（グローバル変数）になります。
# 各関数から共通して見えるようになるので、プログラミングが楽になります。
# どこからでも参照・変更できる利便性の反面、
# 更新履歴を追い難く、デバッグが困難になる不利益もあるので、
# 一般的には好ましくないとされています。
# ここでは、双六作成が容易となるため、
# グローバル変数を許容することとします。
$map_event = ["",   "",   "",   "", "2A", "3B", "",   "SB",
              "",   "1R", "3B", "", "2A", "",   "SB", "3B",
              "2A", "",   "2R", "", "3B", ""]

# 定数宣言
PLAYER        = 0
COMPUTER      = 1
GOAL_POSITION = $map_event.length - 1

# 競技者の名称
$NAMES = ["PLAYER", "COMPUTER"]

#PLAYER, COMPUTER それぞれが、双六上のどの升目にいるか？
$position = [0, 0]

# PLAYER, COMPUTER 何回休みか？
$rest     = [0, 0]

#==============================================================================
# 双六描画
#==============================================================================
def draw_map
  puts ""
  puts " ST  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 GL"
  puts "+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+"

  (PLAYER..COMPUTER).each do |competitor|
    $map_event.each_with_index do |_cell, index|
      printf "| "
      if $position[competitor] == index
        printf $NAMES[competitor][0]
      else
        printf " "
      end
    end
    printf "|\n"
  end

  # event
  puts "+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+"
  puts "|  |  |  |  |2A|3B|  |SB|  |1R|3B|  |2A|  |SB|3B|2A|  |2R|  |3B|  |"
  puts "+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+"
  puts ""
  puts "【凡例】A: 進む B: 戻る R: 休み S:振り出し"
  puts ""
end

#==============================================================================
#開始画面描画
#==============================================================================
def draw_opening
  # Ruby では ; は通常用いませんが、
  # 一行に複数文を記述する際には ; を使うことができます。
  # sleep 1 は一秒間、時の経過を待ちます。
  puts "The Japanese Traditional Game                            "; sleep 1;
  puts "                                                         "; sleep 1;
  puts " ####  #     #  ####   ####  #####   ####  #    # #     #"; sleep 1;
  puts "#      #     # #    # #    # #    # #    # #   #  #     #"; sleep 1;
  puts "#      #     # #      #    # #    # #    # #  #   #     #"; sleep 1;
  puts " ####  #     # #  ### #    # #####  #    # ###    #     #"; sleep 1;
  puts "     # #     # #    # #    # #  #   #    # #  #   #     #"; sleep 1;
  puts "     # ##   ##  #   # #    # #   #  #    # #   #  ##   ##"; sleep 1;
  puts "#####   #####    ###   ####  #    #  ####  #    #  ##### "; sleep 1;
  puts ""; sleep 1;
end


#==============================================================================
# 終了画面描画
#==============================================================================
def draw_ending
  puts "The Japanese Traditional Game                            "; sleep 1;
  puts "                                                         "; sleep 1;
  puts "               Ｓ Ｕ Ｇ Ｏ Ｒ Ｏ Ｋ Ｕ                   "; sleep 1;
  puts "                                                         "; sleep 1;
  puts "                                                  Fin.   "; sleep 1;
end

#==============================================================================
# イベント処理
# 双六上の各イベントを受け取り、競技者の内部状態を適宜変更する
# |  |  |  |  |2A|3B|  |SB|  |1R|3B|  |2A|  |SB|3B|2A|  |2R|  |3B|
# 凡例: nV.
# n: 回数
# V: 動作. go Ahead(進む) / go Backward(戻る) / Rest(休み)
# 2A なら 二枡進む
# 3B なら 三枡戻る
# SB なら スタートまで戻る
# 1R なら 一回休
#==============================================================================
def event(competitor)
  # イベントを取得
  event = $map_event[$position[competitor]]

  # eventが空白なら、何もイベントはなかったとして終了
  return if event.empty?

  # 該当イベントの処理
  times = event[0] # 何升進む、何回休みなどの数
  verbs = event[1] # 進む、戻る、休むの種類

  case verbs
  # 進む
  when 'A'
    $position[competitor] += times.to_i
    # ゴールを通り過ぎていたら、ゴール地点に調整
    if $position[competitor] > GOAL_POSITION
      $position[competitor] = GOAL_POSITION
    end

    # メッセージ表示
    printf "%c> やった〜 %c マス 進んだ！\n", $NAMES[competitor][0], times

  # 戻る
  when 'B'
    if times == 'S'
      # 振り出しに戻る
      $position[competitor] = 0
    else
      # 戻る
      $position[competitor] -= times.to_i
      # スタートを通り過ぎていたら、スタート地点に調整
      if $position[competitor] < 0
        $position[competitor] = 0
      end
    end

    # メッセージ表示
    if times == 'S'
      printf "%c> わ〜ん スタートに 戻ったよ\n", $NAMES[competitor][0]
    else
      printf "%c> わ〜ん %c マス 戻ったよ\n", $NAMES[competitor][0], times
    end

  # 休み
  when 'R'
    $rest[competitor] = times.to_i

    # メッセージ表示
    printf "%c> わ〜ん %c 回 休みだよ\n", $NAMES[competitor][0], times
  end
end

#==============================================================================
# さいころを振って進む
#==============================================================================
def dice_and_walk(competitor)
  # さいころを振って進む
  dice                   = rand(1..6)
  $position[competitor] += dice

  # ゴールを通り過ぎていたら、ゴール地点に調整
  if $position[competitor] > GOAL_POSITION
    $position[competitor] = GOAL_POSITION
  end

  # メッセージ表示
  printf "%c> やった〜 %d マス 進んだ！\n", $NAMES[competitor][0], dice
end

#==============================================================================
# 双六を上がったか、判定関数
#==============================================================================
def goal?(competitor)
  return true if $position[competitor] == GOAL_POSITION
  return false
end

#==============================================================================
# メッセージを表示し、キー入力されるまで待機
#==============================================================================
def message_and_wait(message)
  # メッセージの表示
  puts message
  # キー入力を待つ
  gets
end

#==============================================================================
# メイン処理
#==============================================================================

competitor = PLAYER

# タイトル表示
draw_opening

#双六表示
draw_map

# 何かキーを押すと開始
message_and_wait "Press Enter to Start"

# 競技開始
loop do
  message_and_wait "#{$NAMES[competitor]}の番 Press Enter"

  # ○回休みでなければ
  if $rest[competitor] == 0
    # さいころを振って進む
    dice_and_walk competitor
    # 止まった升目に、イベントが設定されているか
    event competitor
  # お休み回数を減らす
  else
    printf "%c> %d 回休みなので進めない・・・\n", $NAMES[competitor][0], $rest[competitor]
      $rest[competitor] -= 1
  end

  #双六表示
  draw_map

  # どちらかが上がったら中断
  break if goal?(PLAYER) || goal?(COMPUTER)

  # 次の競技者の番にする
  competitor = (competitor + 1) % 2
end

#ゴール到着時のメッセージ
if goal?(competitor)
  printf "%c> 双六を上がったよ*^_^*\n", $NAMES[competitor][0]
end

# エンディングのご案内
message_and_wait "Press Enter to Ending"

# エンディング表示
draw_ending

/**************************************************************************
 * 双六ゲームを創ってみましょう。
 * 止まった升目に「３つ進む」や、「振り出しに戻る」も創ってみましょう。
 * どこまで進んだか分かる表示機能や、
 * オープニング・エンディングもあると楽しいですね。*
 **************************************************************************/

#include "mt.h"
#include <stdio.h>
#include <string.h>

#define MAP_SIZE 22      // 0-21 までの升目がある
#define GOAL_POSITION 21 // 21 の升目が、上がり
#define TRUE 1
#define FALSE 0

// 双六のマップ配置
// 0：スタート
// 1：
// 2：
// 3：
// 4：2マス進む
// 5：3マス戻る
// 6：
// 7：スタートに戻る
// 8：2マス進む
// 9：1回休み
// 10：3マス戻る
// 11：
// 12：2マス進む
// 13：
// 14：スタートに戻る
// 15：3マス戻る
// 16：2マス進む
// 17：
// 18：2回休み
// 19：
// 20：3マス戻る
// 21：ゴール

// main の外側に配置(グローバル変数)して、各関数から共通して見られるようにする。
// (一般的には好ましくないが、双六作成が容易となるため、許容する)
char const *map_event[] = {"",   "",   "",   "", "2A", "3B", "",   "SB",
                           "",   "1R", "3B", "", "2A", "",   "SB", "3B",
                           "2A", "",   "2R", "", "3B", ""};

// 列挙型 cmp(競技者)型の宣言
typedef enum { PLAYER, COMPUTER } cmp;
// cmp型変数 competitorの宣言
cmp competitor;
// #define PLAYER   0
// #define COMPUTER 1 と同じ
// enum のご紹介のみ

//  PLAYER, COMPUTER それぞれが、双六上のどの升目にいるか？
int position[2] = {};
// PLAYER, COMPUTER 何回休みか？
char rest[2];

// 関数のプロトタイプ宣言 省略するため
// main 関数を末尾に記載

// 双六表示機能
void drow_map() {
  int i;
  printf(
      "                                                                   \n");
  printf(
      " ST  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 GL \n");
  printf(
      "+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+\n");
  // player
  for (i = 0; i < MAP_SIZE; i++) {
    printf("| ");
    if (position[PLAYER] == i) {
      printf("P");
    } else {
      printf(" ");
    }
  }
  printf("|\n");
  // computer
  for (i = 0; i < MAP_SIZE; i++) {
    printf("| ");
    if (position[COMPUTER] == i) {
      printf("C");
    } else {
      printf(" ");
    }
  }
  printf("|\n");
  // event
  printf(
      "+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+\n");
  printf(
      "|  |  |  |  |2A|3B|  |SB|  |1R|3B|  |2A|  |SB|3B|2A|  |2R|  |3B|  |\n");
  printf(
      "+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+\n");
  printf(
      "                                                                   \n");
  printf(
      " 【凡例】A: 進む B: 戻る R: 休み S:振り出し                        \n");
  printf(
      "                                                                   \n");
}

void drow_opening() {
  int i;
  for (i = 0; i < 24; i++) {
    puts("");
  }
  puts("##############################################################");
  puts("#                                                            #");
  puts("#  The Japanese Traditional Game                             #");
  puts("#                                                            #");
  puts("#   ####  #     #  ####   ####  #####   ####  #    # #     # #");
  puts("#  #      #     # #    # #    # #    # #    # #   #  #     # #");
  puts("#  #      #     # #      #    # #    # #    # #  #   #     # #");
  puts("#   ####  #     # #  ### #    # #####  #    # ###    #     # #");
  puts("#       # #     # #    # #    # #  #   #    # #  #   #     # #");
  puts("#       # ##   ##  #   # #    # #   #  #    # #   #  ##   ## #");
  puts("#  #####   #####    ###   ####  #    #  ####  #    #  #####  #");
  puts("#                                                            #");
  puts("##############################################################");
  puts("");
}

void drow_ending() {
  puts("");
  puts("##############################################################");
  puts("#                                                            #");
  puts("#   The Japanese Traditional Game                            #");
  puts("#                                                            #");
  puts("#                 Ｓ Ｕ Ｇ Ｏ Ｒ Ｏ Ｋ Ｕ                    #");
  puts("#                                                            #");
  puts("#                                                    Fin.    #");
  puts("#                                                            #");
  puts("##############################################################");
  puts("");
}

// マップ上のイベントを受け取り、競技者の内部状態を適宜変更する
// "|  |  |  |  |2A|3B|  |SB|  |1R|3B|  |2A|  |SB|3B|2A|  |2R|  |3B|  |\n");
// " legend: nV. n: times V: verb. go Ahead / go Backward / Rest       \n");
void event(cmp competitor) {
  if (position[competitor] > GOAL_POSITION) {
    position[competitor] = GOAL_POSITION;
  }

  // イベントを取得
  char event[3];
  strcpy(event, map_event[position[competitor]]);
  if (strlen(event) == 0) {
    // 何もイベントはなかったとして終了
    return;
  }

  // 該当イベントの処理
  char times = event[0]; // 何升進む、何回休みなどの数
  char kind = event[1];  // 進む、戻る、休むの種類
  switch (kind) {
  case 'A': // 進む
    if (times == 'S') {
      // 振り出しに戻る
      position[competitor] = 0;
    } else {
      // 進める
      position[competitor] += (times - '0'); // 文字を数値に変換
      // ゴールを通り過ぎていたら、ゴール地点に調整
      if (position[competitor] > GOAL_POSITION) {
        position[competitor] = GOAL_POSITION;
      }
    }
    // メッセージ表示
    if (competitor == PLAYER) {
      printf("P> やった〜 %d マス 進んだ！\n", times - '0');
    } else {
      printf("C> やった〜 %d マス 進んだ！\n", times - '0');
    }
    break;
  case 'B': // 戻る
    if (times == 'S') {
      // 振り出しに戻る
      position[competitor] = 0;
    } else {
      // 戻る
      position[competitor] -= (times - '0'); // 文字を数値に変換
      // スタートを通り過ぎていたら、スタート地点に調整
      if (position[competitor] < 0) {
        position[competitor] = 0;
      }
    }
    // メッセージ表示
    if (times == 'S') {
      if (competitor == PLAYER) {
        printf("P> わ〜ん スタートに 戻ったよ\n");
      } else {
        printf("C> わ〜ん スタートに 戻ったよ\n");
      }
    } else {
      if (competitor == PLAYER) {
        printf("P> わ〜ん %d マス 戻ったよ\n", times - '0');
      } else {
        printf("C> わ〜ん %d マス 戻ったよ\n", times - '0');
      }
    }
    break;
  case 'R':                           // お休み
    rest[competitor] = (times - '0'); // 文字を数値に変換
    // メッセージ表示
    if (competitor == PLAYER) {
      printf("P> わ〜ん %d 回 休みだよ\n", times - '0');
    } else {
      printf("C> わ〜ん %d 回 休みだよ\n", times - '0');
    }
    break;
  }
}

// さいころを振って進む
void dice_and_walk(cmp competitor) {
  int dice = genrand_int32() % 6 + 1;
  position[competitor] += dice;
  // ゴールを通り過ぎていたら、ゴール地点に調整
  if (position[competitor] > GOAL_POSITION) {
    position[competitor] = GOAL_POSITION;
  }
  // メッセージ表示
  if (competitor == PLAYER) {
    printf("P> やった〜 %d マス 進んだ！\n", dice);
  } else {
    printf("C> やった〜 %d マス 進んだ！\n", dice);
  }
}

// 双六を上がったか、判定関数
int is_goal(cmp competitor) {
  if (position[competitor] == GOAL_POSITION) {
    return TRUE;
  } else {
    return FALSE;
  }
}

int main(int argc, char const *argv[]) {

  // タイトル表示
  drow_opening();

  //双六表示
  drow_map();

  printf("\nPress Enter key\n");
  while (getchar() != '\n')
    ;

  // 競技開始
  // どちらかが上がるまで、続行
  do {

    // PLAYERの番
    printf("\nPLAYERの番 Press Enter key\n");
    while (getchar() != '\n')
      ;

    if (rest[PLAYER] == 0) {
      // ○回休みでなければ、さいころを振って進む
      dice_and_walk(PLAYER);
      // 止まった升目になにかイベントが設定されているか
      event(PLAYER);
    } else {
      // お休み回数を減らす
      printf("P> %d 回休みなので進めない・・・\n", rest[PLAYER]);
      rest[PLAYER]--;
    }

    //双六表示
    drow_map();

    // COMPUTERの番
    printf("\nCOMPUTERの番 Press Enter key\n");
    while (getchar() != '\n')
      ;

    if (rest[COMPUTER] == 0) {
      // ○回休みでなければ、さいころを振って進む
      dice_and_walk(COMPUTER);
      // 止まった升目になにかイベントが設定されているか
      event(COMPUTER);
    } else {
      // お休み回数を減らす
      printf("C> %d 回休みなので進めない・・・\n", rest[COMPUTER]);
      rest[COMPUTER]--;
    }

    //双六表示
    drow_map();

  } while (!is_goal(PLAYER) && !is_goal(COMPUTER));

  //ゴール到着時のメッセージ
  if (is_goal(PLAYER)) {
    printf("P> 双六を上がったよ(*^_^*)\n");
  } else {
    printf("C> 双六を上がったよ(*^_^*)\n");
  }

  // エンディング表示
  drow_ending();

  return 0;
}

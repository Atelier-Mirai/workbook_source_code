/**************************************************************************
 * 双六ゲームを創ってみましょう。
 * 止まった升目に「３つ進む」や、「振り出しに戻る」も創ってみましょう。
 * どこまで進んだか分かる表示機能や、
 * オープニング・エンディングもあると楽しいですね。*
 **************************************************************************/

#include "mt.h"          // 乱数のために
#include <stdio.h>
#include <string.h>
#include <unistd.h>      // sleep関数のために

#define MAP_SIZE      22 // 0-21 までの升目がある
#define GOAL_POSITION 21 // 21 の升目が、上がり
#define TRUE           1 // 真
#define FALSE          0 // 偽

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

// main関数の外側で宣言することにより、
// 大域変数（グローバル変数）になります。
// 各関数から共通して見えるようになるので、プログラミングが楽になります。
// どこからでも参照・変更できる利便性の反面、
// 更新履歴を追い難く、デバッグが困難になる不利益もあるので、
// 一般的には好ましくないとされています。
// ここでは、双六作成が容易となるため、
// グローバル変数を許容することとします。
char const *map_event[] = {"",   "",   "",   "", "2A", "3B", "",   "SB",
                           "",   "1R", "3B", "", "2A", "",   "SB", "3B",
                           "2A", "",   "2R", "", "3B", ""};

// #define PLAYER   0
// #define COMPUTER 1 と定義しても同様です。
// 列挙型(enum) や 型定義(typedef) をご紹介したかったので、使っています。

// 列挙型 cmp(競技者)型の宣言
typedef enum { PLAYER, COMPUTER } cmp;

char const *NAMES[2]   = {"PLAYER", "COMPUTER"};    // 競技者の名称
char const initials[2] = {'P',      'C'};           // それぞれのイニシャル

//  PLAYER, COMPUTER それぞれが、双六上のどの升目にいるか？
int position[2] = {};
// PLAYER, COMPUTER 何回休みか？
char rest[2];

// 関数のプロトタイプ宣言に代えて、直接、関数本体を記述します。
// その後、main 関数を記述します。


/* 双六描画
-------------------------------------------------------------------------*/
void draw_map() {
  int i;
  cmp competitor; // cmp型変数 competitorの宣言

  puts("");
  puts(" ST  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 GL");
  puts("+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+");

  for (competitor = PLAYER; competitor <= COMPUTER; competitor++) {
    for (i = 0; i < MAP_SIZE; i++) {
      printf("| ");
      if (position[competitor] == i) {
        printf("%c", initials[competitor]);
      } else {
        printf(" ");
      }
    }
    printf("|\n");
  }

  // event
  puts("+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+");
  puts("|  |  |  |  |2A|3B|  |SB|  |1R|3B|  |2A|  |SB|3B|2A|  |2R|  |3B|  |");
  puts("+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+");
  puts("");
  puts("【凡例】A: 進む B: 戻る R: 休み S:振り出し");
  puts("");
}

/* 開始画面描画
-------------------------------------------------------------------------*/
void draw_opening() {
  // sleep(1)は一秒間、時の経過を待ちます。
  puts("The Japanese Traditional Game                            "); sleep(1);
  puts("                                                         "); sleep(1);
  puts(" ####  #     #  ####   ####  #####   ####  #    # #     #"); sleep(1);
  puts("#      #     # #    # #    # #    # #    # #   #  #     #"); sleep(1);
  puts("#      #     # #      #    # #    # #    # #  #   #     #"); sleep(1);
  puts(" ####  #     # #  ### #    # #####  #    # ###    #     #"); sleep(1);
  puts("     # #     # #    # #    # #  #   #    # #  #   #     #"); sleep(1);
  puts("     # ##   ##  #   # #    # #   #  #    # #   #  ##   ##"); sleep(1);
  puts("#####   #####    ###   ####  #    #  ####  #    #  ##### "); sleep(1);
}

/* 終了画面描画
-------------------------------------------------------------------------*/
void draw_ending() {
  puts("The Japanese Traditional Game                            "); sleep(1);
  puts("                                                         "); sleep(1);
  puts("               Ｓ Ｕ Ｇ Ｏ Ｒ Ｏ Ｋ Ｕ                   "); sleep(1);
  puts("                                                         "); sleep(1);
  puts("                                                  Fin.   "); sleep(1);
}

/* イベント処理
 * 双六上の各イベントを受け取り、競技者の内部状態を適宜変更する
 * |  |  |  |  |2A|3B|  |SB|  |1R|3B|  |2A|  |SB|3B|2A|  |2R|  |3B|
 * 凡例: nV.
 * n: 回数
 * V: 動作. go Ahead(進む) / go Backward(戻る) / Rest(休み)
 * 2A なら 二枡進む
 * 3B なら 三枡戻る
 * SB なら スタートまで戻る
 * 1R なら 一回休み
-------------------------------------------------------------------------*/
void event(cmp competitor) {
  // イベントを取得
  char event[3];
  strcpy(event, map_event[position[competitor]]);
  if (strlen(event) == 0) {
    // 何もイベントはなかったとして終了
    return;
  }

  // 該当イベントの処理
  char times = event[0]; // 何升進む、何回休みなどの数
  char verbs = event[1]; // 進む、戻る、休むの種類
  switch (verbs) {
  // 進む
  case 'A':
    position[competitor] += (times - '0'); // 文字を数値に変換
    // ゴールを通り過ぎていたら、ゴール地点に調整
    if (position[competitor] > GOAL_POSITION) {
      position[competitor] = GOAL_POSITION;
    }
    // メッセージ表示
    printf("%c> やった〜 %c マス 進んだ！\n", initials[competitor], times);
    break;

  // 戻る
  case 'B':
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
      printf("%c> わ〜ん スタートに 戻ったよ\n", initials[competitor]);
    } else {
      printf("%c> わ〜ん %c マス 戻ったよ\n", initials[competitor], times);
    }
    break;

  // 休み
  case 'R':
    rest[competitor] = (times - '0'); // 文字を数値に変換

    // メッセージ表示
    printf("%c> わ〜ん %c 回 休みだよ\n", initials[competitor], times);
    break;
  }
}

/* さいころを振って進む
-------------------------------------------------------------------------*/
void dice_and_walk(cmp competitor) {
  // さいころを振って進む
  int dice = genrand_int32() % 6 + 1;
  position[competitor] += dice;

  // ゴールを通り過ぎていたら、ゴール地点に調整
  if (position[competitor] > GOAL_POSITION) {
    position[competitor] = GOAL_POSITION;
  }

  // メッセージ表示
  printf("%c> やった〜 %d マス 進んだ！\n", initials[competitor], dice);
}

/* 双六を上がったか、判定関数
-------------------------------------------------------------------------*/
int is_goal(cmp competitor) {
  if (position[competitor] == GOAL_POSITION) {
    return TRUE;
  } else {
    return FALSE;
  }
}

/* メッセージを表示し、キー入力されるまで待機
-------------------------------------------------------------------------*/
void message_and_wait(char const *message){
  // メッセージの表示
  printf("%s", message);
  // キー入力されるまで待機
  while (getchar() != '\n')
    ;
}

/* メイン関数
-------------------------------------------------------------------------*/
int main(int argc, char const *argv[]) {
  cmp competitor = PLAYER; // cmp型変数 competitorの宣言と初期化
  char message[30];        // メッセージ作成用配列を宣言

  // タイトル表示
  draw_opening();

  //双六表示
  draw_map();

  // 何かキーを押すと開始
  message_and_wait("\nPress Enter to Start\n");

  // 競技開始
  do {
    // message = "\nPLAYERの番 Press Enter\n";
    // message = "\nDOMPUTERの番 Press Enter\n";
    // と書けないので、文字配列を初期化し、表示させたい文字列を連結している。
    memset(message, '\0', sizeof(message)); // 初期化
    strcat(message, "\n");
    strcat(message, NAMES[competitor]);
    strcat(message, "の番 Press Enter\n");
    message_and_wait(message);

    // ○回休みでなければ
    if (rest[competitor] == 0) {
      // さいころを振って進む
      dice_and_walk(competitor);
      // 止まった升目に、イベントが設定されているか
      event(competitor);
    // お休み回数を減らす
    } else {
      printf("%c> %d 回休みなので進めない・・・\n",
          initials[competitor], rest[competitor]);
      rest[competitor]--;
    }

    //双六表示
    draw_map();

    // 次の競技者の番にする
    competitor = (competitor + 1) % 2;

  // どちらかが上がるまで、続行
  } while (!is_goal(PLAYER) && !is_goal(COMPUTER));

  //ゴール到着時のメッセージ
  if (is_goal(competitor)) {
    printf("%c> 双六を上がったよ(*^_^*)\n", initials[competitor]);
  }

  // エンディングのご案内
  message_and_wait("\nPress Enter to Ending\n");

  // エンディング表示
  draw_ending();

  return 0;
}

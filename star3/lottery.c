#include <stdio.h>  // 標準入出力関数
#include <string.h> // 文字列操作関数
#include <stdlib.h> // rand関数
#include <time.h>   // time関数

// 乱数はよく使うので、関数化してみました。
// 同じプログラムを何度も書かずに済むので、便利です。
// 自作したrandom_number()関数が定義されています。
// 自作のヘッダーファイルを読み込む際は、
// "(ダブルクォーテーション)で囲みます。
#include "random_number.h"

int main(int argc, char const *argv[]) {
  // 福引きの等級名
  // 配列の添字は0から始まるので、先頭に""を入れています。
  // prize_rank[1] が "一等賞"だと分かりやすいです。
  char *prize_rank[] = {"", "一等賞", "二等賞", "三等賞", "残念賞"};
  // 福引きの賞品
  char *prize_item[] = {"", "世界一周の旅", "温泉一泊二日",
                            "お好み焼き食べ放題", "ティッシュペーパー"};
  // メッセージ
  char message[64];

  // 乱数はよく使うので、流用しています。
  int lottery = random_number(10) + 1; // 福引き 1-10の乱数が得られます。

  int rank; // 何等賞か？
  if (lottery == 1) {
    rank = 1; // 一等賞
  } else if (2 <= lottery && lottery <= 3) {
    rank = 2; // 二等賞
  } else if (4 <= lottery && lottery <= 6) {
    rank = 3; // 三等賞
  } else {
    rank = 4; // 残念賞
  }

  // 小さい順に切り取っているので、
  // else if の下限は省略出来ます。
  if (lottery == 1) {
    rank = 1; // 一等賞
  } else if (lottery <= 3) {
    rank = 2; // 二等賞
  } else if (lottery <= 6) {
    rank = 3; // 三等賞
  } else {
    rank = 4; // 残念賞
  }

  // ちなみに条件式を書けないので、switch case 文には出来ません。

  // それぞれの等級に応じたメッセージを創っています。
  // 練習のために、文字列操作の関数を使っています。
  strcpy(message, "おめでとう！");    // コピー関数
  strcpy(message, prize_rank[rank]);  // コピー関数
  strcat(message, "：");              // 連結関数
  strcat(message, prize_item[rank]);  // 連結関数
  strcat(message, " が当たったよ。"); // 連結関数
  printf("%s\n", message);

  return 0;
}

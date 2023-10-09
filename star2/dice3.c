#include <stdio.h>
#include <stdlib.h> // rand関数が定義されています。
#include <time.h>   // time関数が定義されています。

// 自作したrandom_number()関数が定義されています。
// 自作のヘッダーファイルを読み込む際は、
// "(ダブルクォーテーション)で囲みます。
#include "random_number.h"

int main(int argc, char const *argv[]) {
  // random_number.hを読み込んでいるので、
  // すぐに、random_number関数を使えます。
  int dice = random_number(6) + 1;
  printf("サイコロの目は、%d です。\n", dice);

  // ２で割った余りが０なら、偶数、そうでないなら奇数です。
  if (dice % 2 == 0) {
    printf("偶数です\n");
  } else {
    printf("奇数です\n");
  }

  return 0;
}

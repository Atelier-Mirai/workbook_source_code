#include <stdio.h>
#include <stdlib.h> // rand関数が定義されています。
#include <time.h>   // time関数が定義されています。

// 機能：0〜max未満の乱数を返す
// 引数：int max 乱数の最大値
// 戻値：0〜max未満の乱数
int random_number(int max) {
  srand(time(NULL));
  return (rand() % max);
}

int main(int argc, char const *argv[]) {
  // 乱数はよく使うので、関数化してみました。
  // 同じプログラムを何度も書かずに済むので、便利です。
  // 関数のプロトタイプ宣言をしていないので、
  // mainの前に、random_number関数は書かれている必要があります。
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

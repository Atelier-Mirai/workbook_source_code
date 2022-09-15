#include <stdio.h>
#include <stdlib.h> // rand関数が定義されています。
#include <time.h>   // time関数が定義されています。

int main(int argc, char const *argv[]) {
  int dice;

  // 実行した時刻によって、異なった乱数となるように、
  // 乱数の種を播きます。
  srand(time(NULL));

  // ６で割った余りに、1を加えることで、
  // １〜６までの乱数が得られます。
  dice = rand() % 6 + 1;
  printf("サイコロの目は、%d です。\n", dice);

  // ２で割った余りが０なら、偶数、そうでないなら奇数です。
  if (dice % 2 == 0) {
    printf("偶数です\n");
  } else {
    printf("奇数です\n");
  }

  // 論理和を使って、このように書くことも出来ます。
  if (dice == 2 || dice == 4 || dice == 6) {
    printf("偶数です\n");
  } else {
    printf("奇数です\n");
  }

  // switch case 文を使って書くことも出来ます。
  switch (dice) {
  case 1:
    printf("奇数です\n");
    // このbreak文がないと、
    // case 2: も続けて実行されますので、
    // break文を書いています。
    break;
  case 2:
    printf("偶数です\n");
    break;
  case 3:
    printf("奇数です\n");
    break;
  case 4:
    printf("偶数です\n");
    break;
  case 5:
    printf("奇数です\n");
    break;
  case 6:
    printf("偶数です\n");
    break;
  default:
    printf("エラーです\n");
    // default文のbreak;は不要ですが、
    // 対称性の観点から付けています。
    break;
  }

  // 意図的に、break文を書かず、
  // case 5: まで、スルーさせて、
  // 奇数で在る旨、表示させています。
  switch (dice) {
  case 1:
  case 3:
  case 5:
    printf("奇数です\n");
    break;
  case 2:
  case 4:
  case 6:
    printf("偶数です\n");
    break;
  }

  return 0;
}

#include <stdio.h>  // 標準入出力関数

int main(int argc, char const *argv[]) {
  int year = 2000;  // グレゴリオ暦年

  // if 文は 条件分岐のための基本です。
  // 条件が単純な場合には switch case 文を使うと、
  // すっきり書くことができます。

  // 12で割った余りに応じて、干支を表示します。
  switch (year % 12) {
  case 0:
    printf("申年\n");
    break;
  case 1:
    printf("酉年\n");
    break;
  case 2:
    printf("戌年\n");
    break;
  case 3:
    printf("亥年\n");
    break;
  case 4:
    printf("子年\n");
    break;
  case 5:
    printf("丑年\n");
    break;
  case 6:
    printf("寅年\n");
    break;
  case 7:
    printf("卯年\n");
    break;
  case 8:
    printf("辰年\n");
    break;
  case 9:
    printf("巳年\n");
    break;
  case 10:
    printf("午年\n");
    break;
  case 11:
    printf("未年\n");
    break;
  }

  return 0;
}

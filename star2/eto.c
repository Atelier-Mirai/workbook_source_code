#include <stdio.h>

int main(int argc, char const *argv[]) {
  int year = 2000;

  // switch case 文で、余りに応じて、それぞれの干支を表示します。
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

  // 配列の各要素に、干支を格納すると、より簡潔に記述できます。

  // 12で割った余りを配列の添字するのがポイントです。
  // "申"と一文字に見えますが、
  // 文字コードが utf-8 の場合、3文字(バイト) E7 94 B3 です。
  // char saru[4] = { 'E7', '94', 'B3', '\n' };
  // そして、干支は１２種類ありますから、
  // 配列の配列（＝二次元配列）にすれば、干支の配列になります。
  char eto[][4] = {"申", "酉", "戌", "亥", "子", "丑",
                   "寅", "卯", "辰", "巳", "午", "未"};
  // 配列の一次元目の[4]は必要です。
  // 4 を書かずに、[] とだけ書くと、コンパイルエラーとなります。
  // ポインタを使って次のように書くこともできます。
  // char *eto[] = { "申", "酉", "戌", "亥", "子", "丑",
  //                 "寅", "卯", "辰", "巳", "午", "未" };

  int index;
  index = year % 12;
  printf("あなたの干支は、%s です。\n", eto[index]);

  // 一行に纏めて書くことも出来ます。
  printf("あなたの干支は、%s です。\n", eto[year % 12]);

  return 0;
}

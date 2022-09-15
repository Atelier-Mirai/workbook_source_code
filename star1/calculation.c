#include <stdio.h>

int main(int argc, char const *argv[]) {
  // %d は整数型の書式指定子です。
  // 計算結果を直接表示指せることが出来ます。
  // 掛け算は「×」の代わりに「*」を使います。
  printf("%d\n", 3 + 8 * 3 - 1);

  // 変数に代入してから、出力することも出来ます。
  int answer; // 変数の宣言。整数型の変数 answer を宣言しています。
  answer = 18 / 3 - 1; // 変数への代入。
                       // 割り算は「÷」の代わりに「/」を使います。
  printf("%d\n", answer);

  int result = 18 / (3 - 1); // 直接、変数に初期値を代入することも出来ます。
  printf("%d\n", result);

  // 余りを求める演算（剰余演算子）として、「%」が用意されています。
  printf("%d\n", 31 % 7);

  return 0;
}

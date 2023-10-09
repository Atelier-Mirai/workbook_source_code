#include <stdio.h>

int main(int argc, char const *argv[]) {
  // 変数宣言
  double height = 29.7;     // 小数を扱うには、double型として宣言します。
  double width  = 21.0;
  double area;

  // 面積を計算する
  area = height * width;     // 掛け算は「×」の代わりに「*」を使います。

  // 結果を表示する
  printf("%f\n", area);      // 小数を表示する際の書式指定子には %f を使います。
                             // '\n' は「改行文字」です。
                             // 文末で改行したいときに入れます。
  printf("%8.3f\n", area);   // 8.3f は 全体で8桁、小数点以下3桁で表示します。
  printf("%08.3f\n", area);  // 08.3f とすると、先頭に0埋めして表示します。

  return 0;
}

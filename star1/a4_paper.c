#include <stdio.h>

int main(int argc, char const *argv[]) {
  double height = 29.7; // 小数を扱うには、double型として宣言します。
  double width = 21.0;
  double area;
  area = height * width; // 掛け算は「×」の代わりに「*」を使います。
  printf("%f\n", area); // 小数を表示する際は、%fを使います。

  return 0;
}

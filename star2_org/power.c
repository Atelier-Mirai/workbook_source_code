#include <math.h> // pow 関数
#include <stdio.h>

int main(int argc, char const *argv[]) {
  int n;
  long power = 1;

  // ２の冪乗(べきじょう)を求めます。
  for (n = 1; n <= 20; n++) {
    power *= 2;
    printf("2 の %2d 乗は %8ld です。\n", n, power);
  }

  // 冪乗を求める関数も用意されています。
  for (n = 1; n <= 20; n++) {
    power = pow(2, n);
    printf("2 の %2d 乗は %8ld です。\n", n, power);
  }

  // 16進数で出力する際は、%x を指定します。
  // ここでは、power が long 型なので %lx を指定します。
  // 10進数と16進数との対応も参考までに出力してみます。
  printf("乗数  16進数        10進数\n");
  for (n = 1; n <= 16; n++) {
    power = pow(2, n);
    printf("%2d %11lx %13ld\n", n, power, power);
  }
  for (n = 20; n <= 40; n += 10) {
    power = pow(2, n);
    printf("%2d %11lx %13ld\n", n, power, power);
  }

  return 0;
}

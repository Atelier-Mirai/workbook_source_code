#include <stdio.h>

int main(int argc, char const *argv[]) {
  int n;
  int total;

  // まず足してから10000を越えるか、判定したいので、
  // do while 文を使いました。
  // 後判定ループとも言います。
  // 条件式が、total <= 10000 と
  // 10000以下の間は繰り返すようになっている点も、着目して下さい。
  n = 1;
  total = 0;
  do {
    total = total + n;
    n++;
    // 一行に纏めて書くことも出来ます。
    // total += n++;
  } while (total <= 10000);
  printf("%d を足したら、10000を越えて %d になりました。\n", --n, total);

  // while 文を使って書くことも出来ます。
  // 合計を求める処理が重複していることに着目して下さい。
  n = 1;
  total = 0;
  total = total + n;
  n++;
  while (total <= 10000) {
    total = total + n;
    n++;
  }
  printf("%d を足したら、10000を越えて %d になりました。\n", --n, total);

  // 重複を避けるために、次のように書くことも出来ます。
  // 条件式が逆転していることに着目して下さい。
  n = 1;
  total = 0;
  while (1) {
    total = total + n;
    n++;
    if (total > 10000) {
      break;
    }
  }
  printf("%d を足したら、10000を越えて %d になりました。\n", --n, total);

  return 0;
}

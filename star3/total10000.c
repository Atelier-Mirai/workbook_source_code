#include <stdio.h>

int main(int argc, char const *argv[]) {
  int n;
  int total;

  // while文は繰り返す回数がわからない場合に効果的です。
  // 条件を満たしているかどうかを先に判定しているので、
  // 前判定型反復や前判定ループと呼ばれます。
  // 前判定では、条件によっては一度も反復処理が行われず、終了することがあります。
  n     = 1;
  total = 0;
  while (total <= 10000) {
    total = total + n;
    n++;
  }
  printf("%d を足したら、10000を越えて %d になりました。\n", --n, total);

  // 反復処理を行った後に、
  // 条件を満たしているかどうかを判定したい場合には、
  // do while 文を用います。
  // 後判定型反復や後判定ループと呼ばれます。
  // 後判定では、条件によらず一度は反復処理が行われます。
  n     = 1;
  total = 0;
  do {
    total = total + n;
    n++;
  } while (total <= 10000);
  printf("%d を足したら、10000を越えて %d になりました。\n", --n, total);

  return 0;
}

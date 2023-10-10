/**************************************************************************
 * 完全数とは次のような数のことです。
 * ６は、１でも２でも３でも割り切れます。そして６＝１＋２＋３です。
 * ２８は、１と２と４と７と１４で割り切れます。
 * １と２と４と７と１４を足すと２８になります。
 * ２８の次の完全数は、いくつでしょうか？
 **************************************************************************/
#include <stdio.h>  // 標準入出力関数

// 定数定義
#define TRUE  1
#define FALSE 0

// 完全数判定関数
int is_perfect(int candidate);

int main(int argc, char const *argv[]) {
  // 6  = 2 * 3
  // 28 = 2^2 * 7 である
  // 割り切れるかどうかを調べ、
  // 割り切った数の合計が、もとの数と一致するか調べればよい。
  int perfect_numbers[4] = {6, 28};
  int n = 2; // 2つの完全数が発見されているので

  int candidate = 28 + 2; // 奇数の完全数は知られていないため、
                          // 28 の次の偶数を候補とする

  // 最初の四つの完全数が発見されるまで繰り返す
  while (1) {
    // 完全数の判定は、is_perfect関数で行う
    if (is_perfect(candidate)) {
      // 完全数が発見されたら追加する
      perfect_numbers[n] = candidate;
      n++;
      if (n == 4) {
        break;
      } else {
        candidate += 2;
      }
    } else {
      candidate += 2;
    }
  }

  // 結果表示
  for (int i = 0; i < n; i++) {
    printf("%d 番目の完全数は %5d です。\n", i + 1, perfect_numbers[i]);
  }
}

// 完全数判定関数
int is_perfect(int candidate) {
  int sum = 0; // 総和
  int i;

  for (i = 1; i < candidate; i++) {
    if (candidate % i == 0) {
      sum += i;
    }
  }
  if (sum == candidate) {
    return TRUE;
  } else {
    return FALSE;
  }
}

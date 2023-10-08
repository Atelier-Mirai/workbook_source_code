/**************************************************************************
 * １と自分自身以外で割り切れない数のことを「素数」と言います。
 * １〜１００までの間の素数を表示してみましょう。
 * また１０００個目の素数は何でしょうか？
 **************************************************************************/
#include <stdio.h>

#define TRUE 1
#define FALSE 0

// 素数判定関数
int is_prime(int candidate, int prime_numbers[], int n);

int main(int argc, char const *argv[]) {
  // 素数の数 pi(x) ~= x / log(x) が知られている。
  // なので10000までの素数の数は、たかだか2000 である。
  // よって、要素数2000とする
  int prime_numbers[2000] = {};

  // = {} と書くことで、以下のように各要素を初期化したのと同等となる
  // for (int i = 0; i < 2000; i++){
  //   prime_numbers[i] = 0;
  // }

  prime_numbers[0] = 2; // 2 は 偶数唯一の素数である。
  n                = 1; // 一つの素数が発見されているので
  int candidate    = 3; // 素数候補 3から始める
  int i;

  while (candidate < 10000) {
    // 素数の判定は、is_prime関数に任せ、
    // 素数であったら、配列に追加する
    if (is_prime(candidate, prime_numbers, n)) {
      prime_numbers[n] = candidate;
      n++;
      candidate += 2; // 奇数の候補のみ調べるので、+2 している
    } else {
      candidate += 2;
    }
  }

  // 結果表示
  // （せっかくなので、10000までの素数表示）
  printf("      |     1     2     3     4     5     6     7     8     9    10\n");
  printf("------+------------------------------------------------------------\n");
  for (int i = 0; i < n; i++) {
    if (i % 10 == 0) {
      printf("%5d | ", i);
    }
    if (prime_numbers[i] != 0) {
      printf("%5d ", prime_numbers[i]);
    }
    // 10 個 ずつ 改行
    if ((i + 1) % 10 == 0) {
      printf("\n");
    }
    // 100個ずつ線を表示
    if ((i + 1) % 100 == 0) {
      printf("------+------------------------------------------------------------\n");
    }
  }
  printf("\n");
}

// 素数判定関数
int is_prime(int candidate, int prime_numbers[], int n) {
  int i;
  int precious_metal; // 素数でないにしても、貴金属ではある。

  // 10000(=100*100) が 素数かどうかを調べるには、
  // 100までの素数で割りきれるかどうか、確認すれば良い。
  // ここでは簡単化のために、今までに判明している全ての素数で割り切れるか確認する。
  for (i = 0; i < n; i++) {
    precious_metal = prime_numbers[i]; // 割り切れるかどうか
    if (candidate % precious_metal == 0) {
      // 割り切れたなら、素数ではない。
      return FALSE;
    }
  }
  return TRUE;
}

#include <stdio.h>  // 標準入出力関数

int main(int argc, char const *argv[]) {
  // 10個の数字が入った配列
  // {} を使ってまとめて初期値を与えています。
  // 配列は array(アレイ) と言います。
  int array[] = {3, 14, 15, 92, 65, 35, 89, 79, 24, 58};
  int i;        // 配列の添字(index)

  // 合計をまず初期化して 0 にします。
  int sum = 0;
  // 配列の添字は 0 から始まるので、
  // for 文 も i = 0 と、0 から始めます。
  for (i = 0; i < 10; i++) {
    sum += array[i];
  }

  // 結果を出力します。
  for (i = 0; i < 9; i++) {
    printf("%2d + ", array[i]);
  }
  printf("%2d = %3d です。\n", array[9], sum);

  return 0;
}

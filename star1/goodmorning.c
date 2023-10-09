// 標準入出力(STanDard Input Output)のためのヘッダーファイルを取り込みます。
// これにより、標準で用意されている入力や出力のための関数が使えるようになります。
#include <stdio.h>

// C言語では、プログラムは main関数から始まります。
// 先頭のintは整数型(int)の値を返すことを示します。
// argc は プログラム自身に与えられた引数の個数です。
// argv は プログラム自身に与えられた引数の配列です。
int main(int argc, char const *argv[]) {
  printf("おはようございます\n");  // 画面に文字列を出力します。

  return 0; // 0(正常終了) を返して、終了します。
}

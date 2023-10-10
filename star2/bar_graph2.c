#include <stdio.h>  // 標準入出力関数

// 自作の関数を創って、解くことも出来ます。

// 関数のプロトタイプ(原型)宣言
// 機能：黒い■と白い□を表示する
// 引数：int black_number // 黒い■の数
//       int white_number // 白い□の数
// 戻値：なし
void black_white_box(int black_number, int white_number);

int main(int argc, char const *argv[]) {
  // 変数名は、i でも良いですが、
  // 行の変数であることが分かるようにすると良いです。
  int row;       // 行
  int black_number; // 黒い■の数
  int white_number; // 白い□の数

  // 表示させたい棒グラフの値配列
  int values[] = {1, 4, 7, 3, 2};

  // 値配列の要素数が5なので、5行繰り返せば良いです。
  // 予め配列要素の要素数を求めておくと、より汎用的になります。
  for (row = 0; row < 5; row++) {
    black_number = values[row];       // 黒い■の数
    // 値配列の最大値が7なので、7から引いています。
    // 予め配列要素の最大値を求めておくと、より汎用的になります。
    white_number = 7 - black_number;  // 白い□の数

    // 黒い■と白い□を表示する関数を呼び出し、表示を任せます。
    black_white_box(black_number, white_number);
  }

  return 0;
}

// プロトタイプ宣言を先頭でしているので、
// 自作関数本体を、main関数の後に書くことが出来ます。
void black_white_box(int black_number, int white_number) {
  // C言語では、while(0)が偽となり、while文が終了します。
  // ですので、このようにも書くことが出来ます。
  while (black_number--) {
    printf("■"); // ■を表示します。
  }
  while (white_number--) {
    printf("□"); // ■を表示します。
  }
  printf("\n"); // 改行します。
}

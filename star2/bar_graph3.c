#include <stdio.h>

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

  for (row = 0; row < 5; row++) {
    black_number = 5 - row; // 黒い■の数
    white_number = row;     // 白い□の数

    // 黒い■と白い□を表示する関数を呼び出し、表示を任せます。
    black_white_number(black_number, white_number);
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

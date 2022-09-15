#include <stdio.h>

// 自作の関数を創って、解くことも出来ます。

// 関数のプロトタイプ(原型)宣言
// 機能：黒い■と白い□を表示する
// 引数：int black_box // 黒い■の数
//       int white_box // 白い□の数
// 戻値：なし
void black_white_box(int black_box, int white_box);

int main(int argc, char const *argv[]) {
  // 変数名は、i でも良いですが、
  // 行の変数であることが分かるようにすると良いです。
  int row;       // 行
  int black_box; // 黒い■の数
  int white_box; // 白い□の数

  for (row = 0; row < 5; row++) {
    black_box = 5 - row; // 黒い■の数
    white_box = row;     // 白い□の数

    // 黒い■と白い□を表示する関数を呼び出し、表示を任せます。
    black_white_box(black_box, white_box);
  }

  return 0;
}

// プロトタイプ宣言を先頭でしているので、
// 自作関数本体を、main関数の後に書くことが出来ます。
void black_white_box(int black_box, int white_box) {
  // C言語では、while(0)が偽となり、while文が終了します。
  // ですので、このようにも書くことが出来ます。
  while (black_box--) {
    printf("■"); // ■を表示します。
  }
  while (white_box--) {
    printf("□"); // ■を表示します。
  }
  printf("\n"); // 改行します。
}

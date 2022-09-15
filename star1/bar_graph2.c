#include <stdio.h>

int main(int argc, char const *argv[]) {
  // 変数名は、i でも良いですが、
  // 行の変数であることが分かるようにすると良いです。
  int row;       // 行
  int black_box; // 黒い■の数
  int white_box; // 白い□の数

  for (row = 0; row < 5; row++) {
    black_box = 5 - row; // 黒い■の数
    white_box = row;     // 白い□の数
    // 初期値は設定済みなので、省略出来ます。
    for (; black_box > 0; black_box--) {
      printf("■"); // ■を表示します。
    }
    for (; white_box > 0; white_box--) {
      printf("□"); // ■を表示します。
    }
    printf("\n"); // 改行します。
  }

  return 0;
}

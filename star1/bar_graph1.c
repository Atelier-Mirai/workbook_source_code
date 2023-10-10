#include <stdio.h>  // 標準入出力関数

int main(int argc, char const *argv[]) {
  // 横棒グラフを表示します。
  // 直接、表示することも出来ます。
  printf("■■■■■\n");
  printf("■■■■□\n");
  printf("■■■□□\n");
  printf("■■□□□\n");
  printf("■□□□□\n");

  // ５つのグラフではなく７つのグラフにしたいなど、
  // 数が変わった時にも対応できるよう、
  // 繰り返し構文を使います。
  // 変数名は、i でも良いですが、
  // 行の変数であることが分かるようにすると良いです。
  int row;           // 行
  int black_number;  // 黒い■の数
  int white_number;  // 白い□の数

  for (row = 0; row < 5; row++) {
    black_number = 5 - row; // 黒い■の数
    white_number = row;     // 白い□の数
    // 初期値は設定済みなので、省略出来ます。
    for (; black_number > 0; black_number--) {
      printf("■");         // ■を表示します。
    }
    for (; white_number > 0; white_number--) {
      printf("□");         // ■を表示します。
    }
    printf("\n");           // 改行します。
  }

  return 0;
}

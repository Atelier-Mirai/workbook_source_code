#include <stdio.h>
#include <string.h>

// グラフのX軸, Y軸の上限を定義
#define X_MAX 5
#define Y_MAX 7

int main(int argc, char const *argv[]) {

  // 縦棒グラフを表示する
  // y
  // ^
  // | □□■□□
  // | □□■□□
  // | □□■□□
  // | □■■□□
  // | □■■■□
  // | □■■■■
  // | ■■■■■
  // -------------> x

  // 表示させたい棒グラフの値
  int values[] = {1, 4, 7, 3, 2};
  // グラフ用の二次元配列
  char graph[X_MAX][Y_MAX][6];  // "■", "□" は、UTF-8 では E2 96 A0, E2 96 A1 と
                                // 6文字で表現される為 [6] としている。
  // char graph[X_MAX][Y_MAX];  // '*', 'o' の一文字で表示するなら、これで良い。

  // graph[0]
  // □ graph[0][6]
  // □ graph[0][5]
  // □ graph[0][4]
  // □ graph[0][3]
  // □ graph[0][2]
  // □ graph[0][1]
  // ■ graph[0][0]
  // のようにしたい。

  // value の値に応じて、棒グラフの長さをセットする
  int x, y;
  for (x = 0; x < X_MAX; x++) {
    int value = values[x];
    for (y = 0; y < Y_MAX; y++) {
      if (y < value) {
        // graph[x][y] = "■"; // こう書きたいが、書けないので strcpyを用いる。
        // graph[x][y] = '*';  // '*'のように char型一文字なら = で代入できる。
        strcpy(graph[x][y], "■");
      } else {
        strcpy(graph[x][y], "□");
      }
    }
  }

  // グラフ表示
  for (y = Y_MAX-1; y >= 0; y--) {
    for (x = 0; x < X_MAX; x++) {
      printf("%s", graph[x][y]);
      // '*', 'o' の一文字で表示するなら、%s に代えて %c を用いると良い。
      // printf("%c", graph[x][y]);
    }
    printf("\n");
  }

  return 0;
}

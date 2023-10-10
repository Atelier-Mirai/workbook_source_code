#include <stdio.h>  // 標準入出力関数
#include <limits.h> // 整数の取り得る範囲

int main(int argc, char const *argv[]) {
  // 10個の数字が入った並び替え前の配列
  int array[] = {3, 15, 22, 81, 41, 83, 72, 0, 50, 33};
  int min; // 最小値を格納する変数
  int i;

  // (a) 最小値を求める処理
  // int型の最大値は 2147483647(=2^31-1)です。
  // limit.h に INT_MAX として、定義されています。
  min = INT_MAX;

  // for文で配列の先頭から順に見ていきます。
  for (i = 0; i < 10; i++) {
    // もし、配列の要素が、
    // これまでに判明している最小値よりも、小さかったなら、
    // 新しい最小値が発見されたことになるので、
    // 最小値を更新します。
    if (array[i] < min) {
      min = array[i];
    }
  }

  // (b) min は 配列の最小値 0 となっています。
  // 最小値0 が array の何番目の要素であったかを求めてみましょう。
  int index = 0;             // 最小値 min が何番目の要素であるか
  for (i = 0; i < 10; i++) {
    // 配列の要素と最小値が一致するか、順に比較していきます。
    if (array[i] == min) {
      // もし一致する要素が見つかったならば、
      // 添字を取得して、繰り返しを抜けます。
      index = i;
      break;
    }
  }

  // 結果表示
  for (i = 0; i < 10; i++) {
    printf("array[%d]: %2d\n", i, array[i]);
  }
  printf("最小値: %d 添字: %d\n", min, index);

  // ここで、(a) の最小値を求める処理と、
  // (b) の添字を求める処理が一緒に出来るのではと思えて来ます。
  // 一緒に書くと、次のようになります。

  // 最小値を求めると同時に、
  // 最小値 min が何番目の要素であるか求める処理
  min    = INT_MAX;
  index  = 0;
  for (i = 0; i < 10; i++) {
    if (min > array[i]) {
      min = array[i]; // (a) 最小値を求める
      index = i;      // (b) 添字を求める
    }
  }

  // 結果表示
  // もちろん同じ結果になります。
  for (i = 0; i < 10; i++) {
    printf("array[%d]: %2d\n", i, array[i]);
  }
  printf("最小値: %d 添字: %d\n", min, index);

  return 0;
}

#include "util.h"   // 自作関数いろいろの定義
#include <limits.h> // 整数の取り得る範囲が定義されています。
#include <stdio.h>

int main(int argc, char const *argv[]) {
  // 10個の数字が入った並び替え前の配列
  int array[] = {3, 15, 22, 81, 41, 83, 72, 0, 50, 33};
  int min; // 最小値を格納する変数
  int i;

  // 最小値を求める処理
  min = INT_MAX;
  for (i = 0; i < 10; i++) { // (a)
    if (min > array[i]) {
      min = array[i];
    }
  }

  // それでは、0 が array の何番目の要素であったかを求めてみましょう。
  int index = 0;             // 最小値 min が何番目の要素であるか
  for (i = 0; i < 10; i++) { // (b)
    if (array[i] == min) {
      index = i;
    }
  }

  printf("(a)(b)それぞれ行った場合の結果表示\n");
  for (i = 0; i < 10; i++) {
    printf("array[%d]: %2d \n", i, array[i]);
  }
  printf("min: %d index: %d\n", min, index);

  // ここで、(a) と (b) 同時に出来るのではと思えて来ます。
  // 一緒に書くと、次のようになります。
  // 最小値を求めると同時に、最小値 min が何番目の要素であるか求める
  min = INT_MAX;
  for (i = 0; i < 10; i++) {
    if (min > array[i]) {
      min = array[i]; // (a)
      index = i;      // (b)
    }
  }

  printf("(a)(b)纏めて行った場合の結果表示\n");
  for (i = 0; i < 10; i++) {
    printf("array[%d]: %2d \n", i, array[i]);
  }
  printf("min: %d index: %d\n", min, index);

  // index には、7番目と入っています。
  // 後ろの要素を前の要素に詰めます。
  // array[7] に array[8] を代入して、
  // array[8] に array[9] を代入します。
  for (i = index; i < 9; i++) {
    array[i] = array[i + 1];
  }

  // 前回は、array[9] は特に処理せず、そのままでしたが、
  // 今回は、array[9] に、今求めた、一番小さい数を入れます。
  array[9] = min;

  // 一番小さい数が、array の最後に来ているはずです。
  // 確認の為に出力してみましょう。
  printf("一番小さい数が、最後に来ていることの確認\n");
  for (i = 0; i < 10; i++) {
    printf("array[%d]: %2d \n", i, array[i]);
  }

  // これで、一番小さい数を、最後に持って行くことが出来ました。
  // 次は、０番目〜８番目で並び替え、
  // その次は、０番目〜７番目で並び替え、
  // ということを順番に繰り返していくと、全部の並び替えが完了します。

  // 完成版のプログラムです。
  // ０番目〜何番目までを並び替えるのか、
  // 管理するためのfor文で外側をくるんでいます。
  // この並び替えのアルゴリズムを、選択ソート と言います。

  int sorted; // 今、何番目の要素まで並び替えが終了しているのか。
  for (sorted = 9; sorted >= 1; sorted--) {
    min = INT_MAX;
    for (i = 0; i <= sorted; i++) {
      if (min > array[i]) {
        min = array[i]; // (a)
        index = i;      // (b)
      }
    }
    for (i = index; i < sorted; i++) {
      array[i] = array[i + 1];
    }
    array[sorted] = min;
  }

  printf("\n");
  printf("【選択ソート】並び替え結果\n");
  for (i = 0; i < 10; i++) {
    printf("array[%d]: %2d \n", i, array[i]);
  }

  printf("\n");
  printf("選択ソートの他に、有名な並び替え方法としては、\n");
  printf("クイックソート\n");
  printf("バブルソート\n");
  printf("マージソート\n");
  printf("が、あるので、学習してみて下さい。\n");

  return 0;
}

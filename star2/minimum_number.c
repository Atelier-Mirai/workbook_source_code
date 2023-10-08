#include "util.h"   // 自作関数いろいろの定義
#include <limits.h> // 整数の取り得る範囲が定義されています。
#include <stdio.h>

int main(int argc, char const *argv[]) {
  // 10個の数字が入った配列 纏めて初期値を与えています。
  // 配列は、array（アレイ）と言います。
  // (簡単化のために、同じ数字はないものと仮定しています。)
  int array[] = {3, 15, 22, 81, 41, 83, 72, 0, 50, 33};

  int min;       // 最小値を格納する変数
  min = INT_MAX; // min = 999; と書いてもいいのですが、
                 // ここでは、整数型の取り得る最大値で初期化しています。
  int i;

  // 最小値を求める処理
  // 最初、min に一番大きい数を入れておきます。
  // そして、配列内のそれぞれの要素と比較することで、
  // 一番、小さい数が、minにセットされます。
  for (i = 0; i < 10; i++) {
    if (min > array[i]) {
      min = array[i];
    }
  }
  // 結果発表
  for (i = 0; i < 10; i++) {
    printf("array[%d]: %2d \n", i, array[i]);
  }
  printf("一番小さい数は %d です。\n", min);

  // 二番目に小さい数を求めます。
  // int array[] = { 3, 15, 22, 81, 41, 83, 72, 0, 50, 33 };
  // から、一番小さい数 0 を除いた
  // int array[] = { 3, 15, 22, 81, 41, 83, 72, 50, 33 };
  // の中から、一番小さい数を調べたら、良いことになります。
  // 0 を取り除くには、どうしたらよいのでしょうか？
  // 取り除くのではなく、後ろの要素を前に詰める！ と考えます。
  // 0 は 7 番目の要素ですから、
  // array[7] に array[8] を代入して、
  // array[8] に array[9] を代入すれば、詰めたことになります。
  // そうすると、
  // int array[] = { 3, 15, 22, 81, 41, 83, 72, 50, 33, 33 };
  // という配列になります。

  // それでは、0 が array の何番目の要素であったか、
  // 添字(index)を求めてみましょう。
  int index = 0; // 最小値 min が何番目の要素であるか
  for (i = 0; i < 10; i++) {
    if (array[i] == min) {
      index = i;
    }
  }

  // index には、7番目と入っています。
  // 後ろの要素を前の要素に詰めます。
  // array[7] に array[8] を代入して、
  // array[8] に array[9] を代入します。
  for (i = index; i < 9; i++) {
    array[i] = array[i + 1];
  }

  // 詰まっているかどうか、確認の為に出力してみましょう。
  printf("詰めた結果\n");
  for (i = 0; i < 10; i++) {
    printf("array[%d]: %2d \n", i, array[i]);
  }

  // 二番目に小さい数を調べます。
  min = INT_MAX;
  // 10まで調べなくても、9まででOKです。
  for (i = 0; i < 9; i++) {
    if (min > array[i]) {
      min = array[i];
    }
  }
  // 結果発表
  printf("二番目に小さい数は、%d です。\n", min);

  return 0;
}

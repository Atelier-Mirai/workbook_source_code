#include <stdio.h>  // 標準入出力関数
#include <stdlib.h> // rand関数
#include <time.h>   // time関数

// 乱数はよく使うので、関数化してみました。
// 同じプログラムを何度も書かずに済むので、便利です。
// 自作したrandom_number()関数が定義されています。
// 自作のヘッダーファイルを読み込む際は、
// "(ダブルクォーテーション)で囲みます。
#include "random_number.h"

int main(int argc, char const *argv[]) {
  // 降水確率 0 - 100 % の範囲の乱数
  // 補完機能が働くので、長い変数名でも良いですが、長すぎるかもしれません。
  // 分かりやすいプログラムを書くために、
  // 良い名前を付けてください。
  // 降水確率は 10% 単位なので、0〜10までの乱数を10倍しています。
  int precipitation_probability = random_number(10) * 10;

  // printf文の書式の中で、「%」を表示させるには、「%%」と記述します。
  printf("降水確率は %d %% です\n", precipitation_probability);

  // if else 文の条件式は、
  // 大きい順、あるいは、小さい順にして、
  // 順次、条件に合致させるようにするとよいです。
  if (precipitation_probability <= 30) {
    printf("傘はいらないです\n");
  } else if (precipitation_probability <= 70) {
    printf("持って行った方がいいかも\n");
  } else {
    printf("絶対持って行きましょう\n");
  }

  return 0;
}

#include <stdio.h>
#include <stdlib.h> // rand関数が定義されています。
#include <time.h>   // time関数が定義されています。

// 機能：0〜max未満の乱数を返す
// 引数：int max 乱数の最大値
// 戻値：0〜max未満の乱数
int random_number(int max);

// 0〜max未満の乱数を返す関数
int random_number(int max) {
  srand(time(NULL));
  return (rand() % max);
}

int main(int argc, char const *argv[]) {
  // 乱数はよく使うので、関数化してみました。
  // 同じプログラムを何度も書かずに済むので、便利です。

  // 降水確率 0 - 100 % の範囲の乱数
  // (補完機能が働くので、長い変数名でも良いですが、
  //  さすがに長すぎるかもしれません)
  int precipitation_probability = random_number(101);

  // printf文の書式の中で、「%」を表示させるには、「%%」と記述します。
  printf("降水確率は、%d %% です。\n", precipitation_probability);

  // if else 文の条件式は、
  // 大きい順、あるいは、小さい順にして、
  // 順次、条件に合致させるようにするとよいです。
  if (precipitation_probability <= 20) {
    printf("傘はいらないです\n");
  } else if (precipitation_probability < 90) {
    printf("持って行った方がいいかも\n");
  } else {
    printf("絶対持って行きましょう\n");
  }

  return 0;
}

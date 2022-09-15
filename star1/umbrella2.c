#include <stdio.h>
#include <stdlib.h> // atoi関数用

int main(int argc, char const *argv[]) {

  // コマンドラインから、降水確率を渡すことも出来ます。
  if (argc == 1) {
    printf("【使い方】\n");
    printf("傘を持っていくべきか、助言するプログラムです。\n");
    printf("もし降水確率が、30%% なら、\n");
    printf("%s 30\n", argv[0]); // argv[0] はプログラム自身の名前です。
    printf("と入力して下さい。\n");

    exit(1); // プログラムを終了します。
  }

  // atoi関数は、文字列を数値に変換する関数です。
  // argv[1]が 文字列 "30" なら、
  // precipitation_probability には、整数 30 が入ります。
  int precipitation_probability = atoi(argv[1]);

  if (precipitation_probability <= 20) {
    printf("傘はいらないです\n");
  } else if (precipitation_probability < 90) {
    printf("持って行った方がいいかも\n");
  } else {
    printf("絶対持って行きましょう\n");
  }

  return 0;
}

/**************************************************************************
 * 入力された英単語の長さを表示する
 * （https://nzlife.net/archives/9581 に長い英単語の豆知識があります）
 **************************************************************************/
#include <stdio.h>  // 標準入出力関数
#include <stdlib.h> // rand関数
#include <string.h> // 文字列操作関数

// #define で、TRUE という定数を1であると定義しています
// プログラム中によく使う定数は、このように定義しておくと、
// 意味が分かりやすくて、よいです。
#define TRUE 1

int main(int argc, char const *argv[]) {
  char buffer[64]; // 英単語の読み込み用

  while (TRUE) {
    // 入力を促すメッセージの表示
    printf("英単語を入力して下さい。(終了:bye)\n");

    // ちなみにプログラム学習用なので、
    // scanf("%s", buffer);
    // の一行が簡単だったりします。

    // キーボードから一行読み込む
    // fgets関数で、bufferへ、sizeof(buffer)-1文字分(7文字分),
    // stdin(=キーボード)から読み込む
    if (fgets(buffer, sizeof(buffer), stdin) == NULL) {
      // エラーメッセージ出力
      printf("キーボードから読み込めませんでした。\n");
      exit(1);
    }

    // 改行文字が含まれているかどうか？
    if (strchr(buffer, '\n') != NULL) {
      // cakeエンター のように5文字タイプされたときは、
      // 改行文字（エンター）を文字列の終端記号に置換する
      buffer[strlen(buffer) - 1] = '\0';
    } else {
      // buffer内に、改行文字が含まれていない場合（＝8文字以上続けてタイプされた場合）
      // 最初の7文字は読み込まれているので、残りの入力ストリーム（キーバッファ）をクリアする
      while (getchar() != '\n')
        ;
    }

    // 無限ループとなっているので、
    // プログラム終了のための文字列 "bye" と比較します。
    // strcmp は 比較した文字が小さいとき(辞書順に並べたときに前にくる場合) -1
    // を strcmp は 比較した文字が大きいとき(辞書順に並べたときに後にくる場合)
    // 1 を 返します。そして、C言語では、0以外は真と判断しますので、 if
    // ((strcmp(buffer, "bye"))){ と書いても同じですが、!= 0
    // と明示されていると、 分かりやすいかと思います。
    if ((strcmp(buffer, "bye")) != 0) {
      printf("入力された英単語は、%s ですね。\n", buffer);
      printf("長さは、%lu 文字の単語ですね。\n", strlen(buffer));
      printf("意味は・・・ う〜ん分かりません。\n");
      printf("\n"); // 前の行に\nを二つ入れてもOKですが、
                    // 画面表示と見た目をあわせて置いた方が分かりやすいです。
    } else {
      printf("また、使ってね。bye-bye\n");
      break;
    }
  }

  return 0;
}

/**************************************************************************
 * 足し算ゲームとほぼ同様です。
 * 桁数と、演算の種類をリクエストするようになっています。
 * 簡単なものを創って、より高機能のものへと、拡張していくと良いです。
 **************************************************************************/
#include <stdio.h>  // 標準入出力関係です。
#include <math.h>   // 数学関係の関数が定義されています。
#include <string.h> // 文字列操作に関する関数が定義されています。
#include <stdlib.h> // rand関数が定義されています。
#include <time.h>   // time関数が定義されています。
// 自作したrandom_number()関数が定義されています。
// 自作のヘッダーファイルを読み込む際は、
// "(ダブルクォーテーション)で囲みます。
#include "random_number.h"

int main(int argc, char const *argv[]) {
  int operand1;         // 第一被演算子
  int operand2;         // 第二被演算子
  char operator;        // 演算子（'+', '-', '*', '/' )
  int digit;            // 桁数
  int result;           // 演算結果
  int answer;           // 回答
  int correct;          // 正答数
  int n;                // 繰り返し回数

  // 桁数をリクエスト
  do {
    // 文字を入力されたときのことは、無視します。
    printf("何桁の数字で挑戦しますか？ \n");
    printf("一桁: 1　二桁: 2　三桁: 3　四桁: 4 \n");
    scanf("%d", &digit);
    while (getchar() != '\n')
      ; // キーバッファ読み飛ばす
  } while (digit <= 0 || digit >= 5);

  // 演算子をリクエスト
  do {
    printf("どの演算に挑戦しますか？ \n");
    // 足し算、引き算、掛け算、割り算 のことです。
    // 加算、減算、乗算、除算という呼び方も知っておいて欲しいです。
    printf("加算: + 減算: - 乗算: * 除算: /\n");
    scanf("%c", &operator);
    while (getchar() != '\n')
      ; // キーバッファ読み飛ばす
    // char型 一文字なので、簡単に比較出来ます。
    // 全角で"＋"や"−"なら文字列操作関数を使って下さい。
  } while (operator!= '+' &&
           operator!= '-' &&
           operator!= '*' &&
           operator!= '/');

  correct = 0; // 10問中何問正解か数えるために、初期化します。
  // 1 回目、2 回目 と表示させたいので、
  // for (n = 1; n <= 10; n++) と書いているところに着目して下さい。
  for (n = 1; n <= 10; n++) {
    // 出題処理
    //冪乗を求める関数を使って、必要な桁数に調整します。
    operand1 = random_number(pow(10, digit));
    // do while 文で、異なる数になるまで、繰り返します。
    do {
      operand2 = random_number(pow(10, digit));
      // 0 の割り算は定義されていないので、条件式を変更します。
    } while (operand2 == operand1 || (operator== '/' && operand2 == 0));

    switch (operator) {
    // switch case 文には、文字型も使えます。
    case '+':
      result = operand1 + operand2;
      break;
    case '-':
      result = operand1 - operand2;
      break;
    case '*':
      result = operand1 * operand2;
      break;
    case '/':
      result = operand1 / operand2;
      break;
    }

    // ゲーム名を表示するための場合分けです。
    // こう書いた方が素直です。
    // switch(operator){
    // case '+':
    //   printf("足し算ゲーム %d 回目", i);
    //   break;
    // case '-':
    //   printf("引き算ゲーム %d 回目", i);
    //   break;
    // case '*':
    //   printf("掛け算ゲーム %d 回目", i);
    //   break;
    // case '/':
    //   printf("割り算ゲーム %d 回目", i);
    //   break;
    // }

    // char型が0-127までの数字として扱われることに着目した書き方
    // 連想配列（ハッシュ）のご紹介
    //
    // ASCIIコード表を見ると、
    // '+' 43
    // '-' 45
    // '*' 42
    // '/' 47
    // となっていますので、
    // 47個+1個の大きさの文字列の配列を用意します。
    char game_name[47 + 1][20];
    strcpy(game_name['+'], "足し算");
    // 書いて、配列の初期値を設定します。
    // strcpy(game_name[43], "足し算");
    // と書いたのと同じです。
    strcpy(game_name['-'], "引き算");
    strcpy(game_name['*'], "掛け算");
    strcpy(game_name['/'], "割り算");
    // 実際に printf("%s", game_name['+']);と書くと「足し算」と表示されます。
    // このことをわきまえると、
    printf("%sゲーム %d 回目\n", game_name[operator], n);
    // と書けます。
    //
    // 配列は、添字として、数字をとりましたが、
    // 文字を添字として使えるようになると、分かりやすく便利です。
    // game_name["＋"] = "足し算";
    // の様なイメージです。
    // 連想配列（ハッシュ）として、用意されている言語もあります。
    // 他言語学習の際の参考になさって下さい。

    printf("%d %c %d = ?\n", operand1, operator, operand2);

    // 回答を受け取る
    scanf("%d", &answer);
    while (getchar() != '\n')
      ; // キーバッファ読み飛ばす

    // 正解発表と正答数のカウント
    if (answer == result) {
      printf("正解です。\n");
      correct++;
    } else {
      printf("正解は、%d です。\n", result);
    }
  }

  // 総合結果発表
  printf("10問中 %d 問 正解\n", correct);

  return 0;
}

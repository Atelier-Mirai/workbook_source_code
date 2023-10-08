/**************************************************************************
 * バージョンアップ版です。
 * より片寄りのない乱数を生成する為、
 * 数学者の松本眞さんとと西村拓士さんによって考案された
 * メルセンヌツイスタ（Mersenne Twister）法を用いています。
 * また、ゲームらしく、10題解くのにかかった時間も表示しています。
 **************************************************************************/
#include "mt.h" // Merusenne Twister法による乱数
// 以下の関数が用意されている。
// genrand_int32() //符号なし32ビット長整数
// genrand_int31() //符号なし31ビット長整数
// genrand_real1() //一様実乱数[0,1] (32ビット精度)
// genrand_real2() //一様実乱数[0,1) (32ビット精度)
// genrand_real3() //一様実乱数(0,1) (32ビット精度)
// genrand_res53() //一様実乱数[0,1) (53ビット精度)
// AからBの範囲の整数の乱数が欲しいときには
// genrand_int32()%(B-A+1)+A;
// のような関数を用いればよい。
#include <math.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

int main(int argc, char const *argv[]) {
  int operand1;         // 第一被演算子
  int operand2;         // 第二被演算子
  char operator;        // 演算子（'+', '-', '*', '/' )
  int digit;            // 桁数
  int result;           // 演算結果
  int your_answer;      // 回答
  int correct;          // 正答数
  time_t start_time;    // ゲーム開始時刻
  time_t finish_time;   // ゲーム完了時刻
  int n;                // 繰り返し回数

  // オープニング
  printf("****************************************************\n");
  printf("*                                                   \n");
  printf("*             計算ゲームへようこそ                  \n");
  printf("*                                                   \n");
  printf("****************************************************\n");
  printf("\n");

  // 桁数をリクエスト
  do {
    printf("何桁の数字で挑戦しますか？ \n");
    printf("一桁: 1　二桁: 2　三桁: 3　四桁: 4 \n");
    scanf("%d", &digit);
    while (getchar() != '\n')
      ; // キーバッファ読み飛ばす
  } while (digit <= 0 || digit >= 5);

  // 演算子をリクエスト
  do {
    printf("どの計算に挑戦しますか？ \n");
    printf("加算: + 減算: - 乗算: * 除算: /\n");
    scanf("%c", &operator);
    while (getchar() != '\n')
      ; // キーバッファ読み飛ばす
  } while (operator!= '+' &&
           operator!= '-' &&
           operator!= '*' &&
           operator!= '/');

  // 出題処理
  correct = 0; // 正答数初期化
  time(&start_time);  // ゲーム開始時刻を取得
  for (n = 1; n <= 10; n++) {
    // digit桁の乱数を求める
    // genrand_int32 は 32bit(0-約43億) の整数型の乱数を返すので、
    // 10(または100, 1000, 10000)で割った余りが得たい乱数となる。
    // (int) は、キャストと呼ばれる。
    // pow関数の戻り値はdouble型なので、int型へ変換している。
    if (operator!= '/') {
      operand1 = genrand_int32() % (int)pow(10, digit);
    } else {
      // 除算時、同じ桁同士で演算すると、ほぼ0となるので、調整。
      operand1 = genrand_int32() % (int)pow(10, digit + 1);
    }
    do {
      operand2 = genrand_int32() % (int)pow(10, digit);
    } while (operator== '/' && operand2 == 0); // 0 の除算は定義されていない

    // 正答を用意
    switch (operator) {
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

    // 何回目のゲームか、表示
    switch (operator) {
    case '+':
      printf("足し算ゲーム %d 回目\n", n);
      break;
    case '-':
      printf("引き算ゲーム %d 回目\n", n);
      break;
    case '*':
      printf("掛け算ゲーム %d 回目\n", n);
      break;
    case '/':
      printf("割り算ゲーム %d 回目\n", n);
      break;
    }

    // 出題する
    printf("%d %c %d = ?\n", operand1, operator, operand2);

    // 回答を受け取る
    scanf("%d", &your_answer);
    while (getchar() != '\n')
      ; // キーバッファ読み飛ばす

    // 正解発表と正答数のカウント
    if (your_answer == result) {
      printf("正解です。\n");
      correct++;
    } else {
      printf("正解は、%d です。\n", result);
    }
  }
  // ゲーム完了時刻を取得
  time(&finish_time);

  // 総合結果発表
  printf("****************************************************\n");
  printf("*                                                   \n");
  printf("*               結　果　発　表                      \n");
  printf("*                                                   \n");
  printf("*              10問中 %d 問 正解\n", correct);
  printf("*              %ld 秒 でクリア！\n", finish_time - start_time);
  printf("*                                                   \n");
  printf("*            おめでとうございます！                 \n");
  printf("*                                                   \n");
  printf("****************************************************\n");
  printf("\n");

  return 0;

  // 1 + 1 などが出現せぬよう、
  // 被演算子が重複しないようにしましたが、
  // 重複を許可する、
  // 引き算の結果は正の範囲に納める、
  // 剰余演算を追加するなど、
  // いろいろ発展させていって下さい。
}

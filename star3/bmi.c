/**************************************************************************
 * BMI を算出
 **************************************************************************/
#include <math.h>
#include <stdio.h>

int main(int argc, char const *argv[]) {
  // 変数宣言
  int height; // 身長
  int weight; // 体重
  double bmi; // BMI

  // 入力処理
  printf("身長(cm)を入力して下さい。\n");
  scanf("%d", &height);
  while (getchar() != '\n')
    ;

  printf("体重(kg)を入力して下さい。\n");
  scanf("%d", &weight);
  while (getchar() != '\n')
    ;

  // BMI算出
  // int型のheightを、キャスト演算子(double)を使って、
  // double型に変換しています。
  // 優先順位を明確にするため、
  // ((double)height) を丸括弧で囲ってから、
  // 100 で割っている点に着目して下さい。
  bmi = weight / pow(((double)height) / 100, 2);

  // 結果表示
  printf("BMI は %4.2f です。\n", bmi);
  if (bmi < 18.5) {
    printf("痩せすぎです。\n");
  } else if (bmi < 25) {
    printf("標準です。\n");
  } else {
    printf("肥満です。\n");
  }

  return 0;
}

#include "util.h" // 自作関数いろいろの定義
#include <stdio.h>

int main(int argc, char const *argv[]) {

  int operand1;         // 第一被演算子
  int operand2;         // 第二被演算子
  int operation_result; // 演算結果
  int your_answer;      // 回答
  int correct_answer;   // 正答数
  int i;

  correct_answer = 0; // 10問中何問正解か数えるために、初期化します。
  // 1 回目、2 回目 と表示させたいので、
  // for (i = 1; i <= 10; i++) と書いているところに着目して下さい。
  for (i = 1; i <= 10; i++) {
    // 出題処理
    operand1 = random_number(10);
    // 二つの０〜９までの数を用意します。
    // do while 文で、異なる数になるまで、繰り返します。
    do {
      operand2 = random_number(10);
    } while (operand2 == operand1);

    operation_result = operand1 + operand2; // 演算結果
    printf("足し算ゲーム %d 回目", i);
    printf("%d + %d = ?\n", operand1, operand2);

    // 回答を受け取る
    scanf("%d", &your_answer);
    while (getchar() != '\n')
      ; // キーバッファ読み飛ばす

    // 正解発表と正答数のカウント
    if (your_answer == operation_result) {
      printf("正解です。\n");
      correct_answer++;
    } else {
      printf("正解は、%d です。\n", operation_result);
    }
  }

  // 総合結果発表
  printf("10問中 %d 問 正解です。\n", correct_answer);

  return 0;
}

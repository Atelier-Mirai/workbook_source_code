#include <stdio.h>  // 標準入出力関数

int main(int argc, char const *argv[]) {

  int operand1;         // 第一被演算子
  int operand2;         // 第二被演算子
  int result;           // 演算結果
  int answer;           // 回答
  int correct;          // 正答数
  int n;                // 繰り返し回数

  correct = 0;          // 10問中何問正解か数えるために、初期化します。

  // 1 回目、2 回目 と表示させたいので、
  // for (n = 1; n <= 10; n++) と書いているところに着目して下さい。
  for (n = 1; n <= 10; n++) {
    // 出題処理
    operand1 = random_number(10);
    // 二つの０〜９までの数を用意します。
    // do while 文で、異なる数になるまで、繰り返します。
    do {
      operand2 = random_number(10);
    } while (operand2 == operand1);

    result = operand1 + operand2; // 演算結果
    printf("足し算ゲーム %d 回目", n);
    printf("%d + %d = ?\n", operand1, operand2);

    // 回答を受け取る
    scanf("%d", &answer);
    while (getchar() != '\n')
      ; // キーバッファ読み飛ばす

    // 正解発表と正答数のカウント
    if (answer == result) {
      printf("正解です。\n");
      correct++;
    } else {
      printf("正解は %d です。\n", result);
    }
  }

  // 総合結果発表
  printf("10問中 %d問 正解です。\n", correct);

  return 0;
}

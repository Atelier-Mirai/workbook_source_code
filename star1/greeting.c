#include <stdio.h>  // 標準入出力関数

int main(int argc, char const *argv[]) {
  // 変数の宣言
  int hour;                          // 今何時か、格納するための変数

  printf("今何時ですか？\n");        // 入力を促すために、メッセージを表示
  scanf("%d", &hour);                // 整数型の数字を、受け取る

  // 時刻に応じた挨拶をする
  if (hour < 12) {                   // 午前中
    // 「\n」は「改行文字」で、改行されます。
    printf("おはようございます\n");
  } else if (hour < 18) {            // 夕方まで
    printf("こんにちは\n");
  } else {                           // 夜なら
    // puts関数を使うと、改行文字も含めて出力されます。
    puts("おやすみなさい");
  }

  return 0;
}

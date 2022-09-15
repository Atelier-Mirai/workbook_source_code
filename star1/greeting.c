#include <stdio.h>

int main(int argc, char const *argv[]) {
  // 変数の宣言
  int what_time_is_it_now; // 今何時か、格納するための変数

  printf("今何時ですか？\n"); // 入力を促すために、メッセージを表示
  scanf("%d", &what_time_is_it_now); // 整数型の数字を、受け取る

  // 時刻に応じた挨拶をする
  if (what_time_is_it_now < 12) { // 午前中
    // 「\n」は「改行文字」で、改行されます。
    printf("おはようございます。\n");
  } else if (what_time_is_it_now < 18) { // 夕方まで
    printf("こんにちは。\n");
  } else { // 夜なら
    // puts関数を使うことも出来ます。
    // 改行まで行ってくれます。
    puts("おやすみなさい。");
  }

  return 0;
}

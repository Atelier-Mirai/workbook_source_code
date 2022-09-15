#include <stdio.h>

int main(int argc, char const *argv[]) {
  int multiplier;   // 乗数　（掛ける数）
  int multiplicand; // 被乗数 （掛けられる数）

  // 掛け算九九の表を表示する
  printf(" 一 二 三 四 五 六 七 八 九\n");
  printf(" の の の の の の の の の\n");
  printf(" 段 段 段 段 段 段 段 段 段\n");
  for (multiplier = 1; multiplier <= 9; multiplier++) {
    for (multiplicand = 1; multiplicand <= 9; multiplicand++) {
      printf("%3d", multiplicand * multiplier);
    }
    printf("\n");
  }

  return 0;
}

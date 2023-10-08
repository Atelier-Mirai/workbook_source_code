#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <locale.h>
#include <wchar.h>

int main() {
  setlocale(LC_CTYPE, "ja_JP.UTF-8");

  char str1[] = "(ﾟ∀ﾟ)( ﾟ∀)超( ﾟ)絶( )大(ﾟ )興(∀ﾟ )奮(ﾟ∀ﾟ)━ｷﾀｰ!!!!";

  // 十分なメモリ領域を確保
  size_t capacity = strlen(str1) + 1;
  wchar_t *str2 = (wchar_t *)malloc(sizeof(wchar_t) * capacity);

  // char -> wchar_tの変換
  int result = mbstowcs(str2, str1, capacity);

  if (result <= 0) {
    fprintf(stderr, "マルチバイト文字列の変換に失敗\n");
    return EXIT_FAILURE;
  }

  printf("バイト長: %lu\n", capacity - 1);
  printf("長さ: %d\n", result);

  // 十分なメモリ領域を確保
  capacity = wcslen(str2) * 6 + 1;
  char* str3 = (char *)malloc(sizeof(char) * capacity);

  // wchar_t -> charの変換
  result = wcstombs(str3, str2, capacity);

  if (result <= 0) {
    fprintf(stderr, "ワイド文字列の変換に失敗");
    return EXIT_FAILURE;
  }

  printf("文字列: %s\n", str3);
  printf("1文字目: %lc\n", str2[0]);
  printf("2文字目: %lc\n", str2[1]);
  printf("3文字目: %lc\n", str2[2]);
  printf("1文字目: %lc\n", str1[0]);
  printf("2文字目: %lc\n", str1[1]);
  printf("3文字目: %lc\n", str1[2]);
}

#include <stdio.h>

int main(int argc, char const *argv[]) {
  double deposit = 1.0; // 定期預金
  int    year    = 0;   // 預けた年数

  // 繰り返す回数が分からない場合は、while文を使います。
  // 定期預金が2倍未満の間、繰り返します。
  while (deposit < 2.0) {
    // deposit *= 1.03; // と書くことも出来ます。
    deposit = deposit * 1.03;
    year++;
  }

  printf("今年預けた定期預金は %d 年後に %5.3f 倍になりました。\n",
         // 長くなった場合、カンマの後で改行することも出来ます。
         year, deposit);

  return 0;
}

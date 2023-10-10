#include <stdio.h>  // 標準入出力関数

// お金が2倍になる期間を知る目安として、
// 「72の法則」が知られています。
// 金利3% なら 72 ÷ 3 = 24 年で 2倍になるという法則です。

int main(int argc, char const *argv[]) {
  int    n       = 1;    // 倍率
  char   buffer[80];     // sprintfのための文字列バッファ

  for (n = 1; n <= 4; n++) {
    double rate    = 0.03; // 金利
    double deposit = 1.0;  // 定期預金
    int    year    = 0;    // 預けた年数

    // 繰り返す回数が分からない場合は、while文を使います。
    // 定期預金が2倍未満の間、繰り返します。
    while (deposit < 2.0) {
      // 自己代入演算子を使って
      // deposit *= (1 + rate * n);
      // と書くことも出来ます。
      deposit = deposit * (1 + rate * n);
      year++;
    }

    // printf の中で % を出力したい時には、%% と書きます。
    printf("年利 %4.1f%% の定期預金は %2d 年後に %5.3f 倍になりました。\n",
           // 長くなった場合、カンマの後で改行することも出来ます。
           (rate * 100 * n), year, deposit);

    // sprintf 文は 書式指定した文字列を返す関数です
    sprintf(buffer, "年利 %4.1f%% の定期預金は %2d 年後に %5.3f 倍になりました。\n",
          (rate * 100 * n), year, deposit);
    // 書式に従って、セットされた文字列を出力します。
    printf("%s", buffer);
  }

  return 0;
}

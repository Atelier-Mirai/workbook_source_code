#include <math.h> // floor, ceil関数
#include <stdio.h>

int main(int argc, char const *argv[]) {

  // 消費税を求めます。
  int icecream = 98; // アイスクリームの値段
  // 消費税率
  // 変数にしておくと、変更があった場合の修正が楽です。
  double consumption_tax_rate = 0.08;
  double consumption_tax; // 消費税額

  consumption_tax = icecream * 3 * consumption_tax_rate;
  // %-5d で左詰で5桁表示されます。
  printf("お買い上げ額は、　　%-5d  円です。\n", icecream * 3);
  printf("消費税は、　　　　　%6.2f 円です。\n", consumption_tax);
  // 切り捨て floorは床の意味です。
  printf("端数を切り捨てると、%6.2f 円です。\n", floor(consumption_tax));
  // 切り上げ ceilは天井の意味です。
  printf("端数を切り上げると、%6.2f 円です。\n", ceil(consumption_tax));

  return 0;
}

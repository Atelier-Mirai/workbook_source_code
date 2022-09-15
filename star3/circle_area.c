#include <math.h> // 円周率 M_PI が定義されています
#include <stdio.h>

int main(int argc, char const *argv[]) {
  int radius = 10;                     // 円の半径
  double area = pow(radius, 2) * M_PI; // 円の面積
                                       // pow関数で、2乗を求めています。

  printf("円周率 = %f\n", M_PI);   // 特に書式を指定しなかった場合
  printf("円周率 = %.4f\n", M_PI); // 小数点以下４桁表示
  printf("円周率 = %.15f\n", M_PI); // 小数点以下１５桁表示
  printf("半径 %d の円の面積は、%.15f です。\n", radius, area);

  return 0;
}

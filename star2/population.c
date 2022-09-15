#include <stdio.h>
#include <string.h>

int main(int argc, char const *argv[]) {

  long population = 8000000000; // 世界人口
                                // 約21億以上の数は、long型を使います。
  double growth_rate = 0.01; // 人口増加率 1%

  // int, double, long
  // それぞれの型が自動的に変換されていることに着目して下さい。
  long next_year_population = population * (1 + growth_rate);

  // long型の書式指定子は、%ld です。
  printf("来年の人口は %ld 人です。\n", next_year_population);

  // 何年後に100億人になるか、求めてみましょう。
  // 繰返し回数が不明な場合は、while文を使います。
  int year = 0;
  while (population < 1e10) { // 1e10 は、10の10乗(=100億)です。
    population *= (1 + growth_rate);
    year++;
    printf("%d 年後の人口は %ld 人です。\n", year, population);
  }

  // おまけ
  // ３桁ごとにカンマ区切りで出してみましょう。
  // 数としての人口を文字列に変換します。
  char str_population[32];         // 世界人口が入った文字列
  char str_population_reverse[32]; // 逆順になっている文字列（作業用）
  char str_comma_population_reverse
      [32]; // カンマを入れて逆順になっている文字列（作業用）
  char str_comma_population[32]; // カンマを入れた文字列
  sprintf(str_population, "%ld", next_year_population);
  int digit = strlen(str_population);
  printf("%d 桁の数です。\n", digit);

  //                        0123456789
  // str_population       : 8000000000
  // str_comma_population : 8,000,000,000

  // カンマは、最後の桁から3つごとに入れていきます。
  // 最後から数えて3つずつカンマを入れていくのは、
  // 扱いにくいので、先頭から3つずつ入れていけば良いように、
  // 逆順に並び替えます。
  // 8000000000 -> 0000000008
  int i;
  for (i = 0; i < digit; i++) {
    str_population_reverse[digit - i - 1] = str_population[i];
  }
  // 文字列の終わりが分かるように最後に'\0'を入れます。
  str_population_reverse[digit] = '\0';
  printf("逆順に並び替えて、%s となりました。\n", str_population_reverse);

  // 3桁ごとにカンマを入れていきます。
  int comma = 0; // 今までに入れたカンマの数
  for (i = 0; i < digit; i++) {
    str_comma_population_reverse[i + comma] = str_population_reverse[i];
    // 0桁目、1桁目では何もしませんが、
    // 2桁目のコピーが終わった後に、
    // カンマを追加する処理を行います。
    if (i % 3 == 2) {
      comma++;
      str_comma_population_reverse[i + comma] = ',';
    }
  }
  // 文字列の終わりが分かるように最後に'\0'を入れます。
  str_comma_population_reverse[digit + comma] = '\0';
  printf("カンマを追加して、%s となりました。\n", str_comma_population_reverse);

  // もう一度、並び替えます。
  for (i = 0; i < digit + comma; i++) {
    str_comma_population[digit + comma - i - 1] =
        str_comma_population_reverse[i];
  }
  // 文字列の終わりが分かるように最後に'\0'を入れます。
  str_comma_population[digit + comma] = '\0';
  printf("もう一度並び替えて、%s となりました。\n", str_comma_population);

  return 0;
}

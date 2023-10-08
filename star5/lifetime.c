/**************************************************************************
 * 1980年1月1日生まれの人は、今日までに何日生きたことになるでしょうか？
 * (生年月日は 19800101 と入力されます。)
 * 昭和20年8月10日生まれの方は、どうでしょうか？
 * (生年月日は 3200810 と入力されます。)
 * 生後30000日目を迎えるのは、何年何月何日でしょうか？
 **************************************************************************/

#include <math.h>   // floor関数のために
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>   // 日付時刻の操作用関数

// グレゴリオ暦から修正ユリウス日を返す為の関数
int gregorian_to_mjd(int year, int month, int date);

// 修正ユリウス日(mjd)からグレゴリオ暦(y, m, d)を返す為の関数
void mjd_to_gregorian(int mjd, int *y, int *m, int *d);

int main(int argc, char const *argv[]) {
  // コマンドラインからの引数がなければ、使い方表示
  if (argc == 1) {
    printf("【使い方】\n");
    printf("今日まで何日生きたかを表示します。\n");
    printf("1980年1月1日生まれであれば、\n");
    printf("%s 19800101\n", argv[0]);
    printf("昭和20年8月10日生まれであれば、\n");
    printf("%s 3200810\n", argv[0]);
    printf("の様に入力して下さい。\n");
    exit(1);
  }

  int birthday; // 生年月日
  char *endptr; // 数値に変換出来なかった文字
  int b_year;   // 誕生日のグレゴリオ暦年
  int b_month;  // 誕生日の月
  int b_day;    // 誕生日の日

  // 簡易エラーチェック
  // 数値変換不可の文字列の長さを調べる。
  birthday = strtol(argv[1], &endptr, 10); // 10進数として変換する
  if (strlen(endptr) != 0) {
    // エラーメッセージ出力
    printf("%s は、生年月日として認識出来ませんでした。\n", endptr);
    exit(1);
  }

  // 生年月日に分離する
  // 年
  // 元号入力なら、グレゴリオ暦へ変換
  if (birthday < 1e7) {
    int ge = birthday / 10000; // 上3桁 元号符号+元号年
    switch (ge / 100) {
    case 1:
      b_year = ge % 100 + 1867;
      break;
    case 2:
      b_year = ge % 100 + 1911;
      break;
    case 3:
      b_year = ge % 100 + 1925;
      break;
    case 4:
      b_year = ge % 100 + 1988;
      break;
    case 5:
      b_year = ge % 100 + 2018;
      break;
    }
  } else {
    b_year = birthday / 10000; // 上4桁はグレゴリオ暦年
  }
  // 月
  b_month = birthday / 100; // 下二桁を切り捨てて
  b_month = b_month % 100;  // 残った数の下2桁

  // 日
  b_day   = birthday % 100; // 下2桁は日

  // http://simd.jugem.jp/?eid=149 より引用
  // 今日の日付を取得する
  time_t now;
  struct tm *ltm;
  time(&now);
  ltm = localtime(&now);

  // 確認用
  // printf( "%5d : [年]\n", ltm->tm_year + 1900 );
  // printf( "%5d : [月]\n", ltm->tm_mon + 1 );
  // printf( "%5d : [日]\n", ltm->tm_mday );
  // printf( "%5d : [時]\n", ltm->tm_hour );
  // printf( "%5d : [分]\n", ltm->tm_min );
  // printf( "%5d : [秒]\n", ltm->tm_sec );
  // printf( "%5d : [曜日]\n", ltm->tm_wday );
  // printf( "%5d : [経過日数]\n", ltm->tm_yday );
  // printf( "%5d : [夏時間の有無]\n", ltm->tm_isdst );

  int t_year  = ltm->tm_year + 1900; // 今日のグレゴリオ暦年
  int t_month = ltm->tm_mon + 1;     // 今日の月
  int t_day   = ltm->tm_mday;        // 今日の日

  // strftime関数を用いて文字列にすることも可能
  // char str_time[100];
  // int  maxsize = 100;
  // char *format = "%Y年%m月%d日 %H:%M";
  // strftime(str_time, maxsize, format, ltm);
  // printf("%s\n", str_time);

  // まともに暦の日付計算をしようとすると大変なので、
  // ある基準日からの経過日数を求めることにします。
  // 今日は、  基準日から何日目
  // 誕生日は、基準日から何日目 と分かれば、
  // 引き算することで、日数を計算出来ます。
  // ユリウス通日（つうじつ）として知られており、
  // 紀元前4713年1月1日 を第一日として、
  // 天文学などの分野で用いられています。
  // ユリウス通日は桁数が大きくなるので、
  // ここから240万日を引いた修正ユリウス日も用いられます。
  // https://ja.wikipedia.org/wiki/ユリウス通日
  // に公式がありますので、プログラミングしました。
  // https://ufcpp.net/study/algorithm/o_days.html
  // にも分かりやすい説明がありますので、ご一読ください。

  printf("今日は　　　 %4d 年 %2d 月 %2d 日です。\n", t_year, t_month, t_day);
  printf("誕生日は　　 %4d 年 %2d 月 %2d 日です。\n", b_year, b_month, b_day);

  // 今日の修正ユリウス日
  int today_mjd    = gregorian_to_mjd(t_year, t_month, t_day);
  // printf("%5d\n", today_mjd);
  int birthday_mjd = gregorian_to_mjd(b_year, b_month, b_day);
  // printf("%5d\n", birthday_mjd);

  // 結果表示
  printf("今日は生まれて %5d 日目 です。\n", today_mjd - birthday_mjd + 1);

  // 生まれてから30000日後がいつかを求めます。
  int life_30000_mjd = birthday_mjd + 30000;
  int l_year, l_month, l_day;
  // l_year, l_month, l_day に値がセットされるよう、アドレスを渡します。
  mjd_to_gregorian(life_30000_mjd, &l_year, &l_month, &l_day);
  printf("生後三万日は %4d 年 %2d 月 %2d 日です。\n", l_year, l_month, l_day);

  return 0;
}

// グレゴリオ暦から修正ユリウス日を返す為の関数
int gregorian_to_mjd(int year, int month, int date) {
  // 1月や2月は前年の13月,14月として扱う
  if (month == 1 || month == 2) {
    month += 12;
    year  -= 1;
  }

  // 公式に従い、修正ユリウス日mjdを求める
  int mjd = floor(365.25 * year)
          + floor(year / 400)
          - floor(year / 100)
          + floor(30.59 * (month - 2))
          + date
          - 678912;

  // 算出結果を返す
  return mjd;
}

// 修正ユリウス日(mjd)からグレゴリオ暦(y, m, d)を返す為の関数
void mjd_to_gregorian(int mjd, int *y, int *m, int *d) {
  // 複数の値を返すときは、ポインタで返します

  int n = mjd + 678881;
  // floor関数はdouble型を返すので、整数型(int)へキャスト
  int a = 4*n + 3 + 4*(int)floor((3.0/4.0) * (4*(n+1)/146097 + 1));
  int b = 5 * ((a % 1461) / 4) + 2;
  *y = a / 1461;
  *m = b / 153 + 3;
  *d = (b % 153) / 5 + 1;
  // 1月や2月は前年の13月,14月として扱う
  if (*m == 13 || *m == 14) {
    *m -= 12;
    *y += 1;
  }
}

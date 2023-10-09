#include <stdio.h>
#include <time.h> // 時刻に関する関数がいろいろ用意されています。（今回未使用）

int main(int argc, char const *argv[]) {
  int time = 123456789;
  int years;
  int days;
  int hours;
  int minutes;
  int seconds;

  years   = time / 31536000;  // 31536000秒で割った商が時間です。
  time    = time % 31536000;  // 31536000秒で割った余りが残り時間です。
  days    = time / 86400;     // 86400秒で割った商が時間です。
  time    = time % 86400;     // 86400秒で割った余りが残り時間です。
  hours   = time / 3600;      // 3600秒で割った商が時間です。
  time    = time % 3600;      // 3600秒で割った余りが残り時間です。
  minutes = time /   60;      // 60秒で割った商が分です。
  seconds = time %   60;      // 60秒で割った余りが残り時間です。
  printf("%d 年 %d 日 %d 時間 %d 分 %d 秒 です。\n",
          years, days, hours, minutes, seconds);

  // 31536000などと大きな数が出てきました。
  // 何の数字であるか分かりやすいよう、以下のように書くと良いです。
  time    = 123456789;
  years   = time / (365 * 24 * 60 * 60);
  time    = time % (365 * 24 * 60 * 60);
  days    = time / (24 * 60 * 60);
  time    = time % (24 * 60 * 60);
  hours   = time / (60 * 60);
  time    = time % (60 * 60);
  minutes = time / (60);
  seconds = time % (60);
  printf("%d 年 %d 日 %d 時間 %d 分 %d 秒 です。\n",
          years, days, hours, minutes, seconds);

  // yearsなど上の位から順に求めてきましたが、
  // seconds など下の位から順に求めると、
  // 31536000などの大きな数が出現せず、扱い易いです。
  time    = 123456789;
  seconds = time % 60;
  time    = time / 60;
  minutes = time % 60;
  time    = time / 60;
  hours   = time % 24;
  time    = time / 24;
  days    = time % 365;
  years   = time / 365;
  printf("%d 年 %d 日 %d 時間 %d 分 %d 秒 です。\n",
          years, days, hours, minutes, seconds);

  return 0;
}

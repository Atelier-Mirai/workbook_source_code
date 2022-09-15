#include <stdio.h>
#include <time.h> // 時刻に関する関数がいろいろ用意されています。（今回未使用）

int main(int argc, char const *argv[]) {
  int remain_time = 4680;
  int hour;
  int minute;
  int second;

  hour = remain_time / 3600; // 3600秒で割った商が時間です。
  remain_time = remain_time % 3600; // 3600秒で割った余りが残り時間です。
  minute = remain_time / 60;      // 60秒で割った商が分です。
  remain_time = remain_time % 60; // 60秒で割った余りが残り時間です。
  second = remain_time;

  printf("4680秒は、%d 時間 %d 分 %d 秒 です。\n", hour, minute, second);

  // 時刻に関する関数を使って求めることも出来ます。
  // 興味のある方は、挑戦されて下さい。

  return 0;
}

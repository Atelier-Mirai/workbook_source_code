#include <stdio.h>

int main(int argc, char const *argv[]) {
  // 一般的には、鶴の数をt, 亀の数をkとすると、
  //  t +  k =  8
  // 2t + 4k = 26
  // という連立一次方程式になります。
  // これを解くためのアルゴリズムとして、
  // ガウス法などがあります。
  // ここでは、単純に力づくで解くこととします。
  int tsuru;
  int kame;
  for (tsuru = 0; tsuru <= 8; tsuru++) {
    kame = 8 - tsuru;

    if (tsuru * 2 + kame * 4 == 26) {
      break;
    }
  }

  printf("鶴は %d 羽、亀は %d 匹います。\n", tsuru, kame);
}

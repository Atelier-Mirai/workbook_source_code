/**************************************************************************
 * １０人の名前が格納された配列と、１０人の点数が格納された配列があります。
 * 成績の良い順に名前と点数を表示してみましょう。
 *
 *  C 言語には、クイックソート(quicksort)と呼ばれるアルゴリズムで
 *  実装された関数が標準で用意されていますので、今回はこれを用います。
 *  (前回、作成したプログラムを流用してももちろんOKです)
 *
 *  クイックソートに関しては、
 *  https://ja.wikipedia.org/wiki/クイックソート
 *  を参照して下さい。
 *
 *  qsortの利用方法については、
 *  http://www.cc.kyoto-su.ac.jp/~yamada/ap/qsort.html より、引用
 **************************************************************************/
#include <stdio.h>
#include <stdlib.h> // quicksort
#include <string.h>

// 比較関数（大小判断を返す関数）
int compare_int(const void *a, const void *b) {
  // b > a なら 正の数を返す。(降順)
  return *(int *)b - *(int *)a;
}

int main(int argc, char const *argv[]) {
  // 変数宣言
  char *name[] = {"亜希子", "加世子", "小夜子", "妙子", "奈美子",
                  "太郎",   "次郎",   "三郎",   "四郎", "五郎"};
  int score[] = {99, 88, 77, 66, 55, 55, 64, 73, 82, 91};
  int backup[10];
  int i, j, s;

  // 結果表示
  printf("並び替え前:\n");
  for (i = 0; i < 10; i++) {
    printf("%d %s \n", score[i], name[i]);
  }

  // 並び替えすると、元の配列が破壊されるため、バックアップを取る
  // for 文で 一要素ずつコピーしても良いが、
  // memcpy 関数を紹介
  memcpy(backup, score, sizeof(int) * 10); // int型10要素分をbackupへコピー

  // 確認用
  // printf("score backup\n");
  // for (i = 0; i < 10; i++){
  //   printf("%d %d \n", score[i], backup[i]);
  // }

  // 並び替えを行う
  // 並び替えたい配列名, 要素数, 配列1要素分のサイズ, 大小比較に用いる関数名
  qsort(score, 10, sizeof(int), compare_int);

  // 確認用
  // printf("並び替え後:\n");
  // for (i = 0; i < 10; i++){
  //   printf("%d\n", score[i]);
  // }

  printf("並び替え後:\n");
  // 並び替え結果に基づいて、名前を表示する
  for (i = 0; i < 10; i++) {
    // 例) i = 1 のとき s には 91 点が入っている
    // 名前も連動して並び替えられると良いが、
    // そういう作りにはしていないので、
    // backup配列を参照して、
    // 91 点の人は何番目であったか、
    // 検索する
    s = score[i];
    for (j = 0; j < 10; j++) {
      if (s == backup[j]) {
        // 同じ点数（奈美子と太郎）の場合、太郎が表示されなくなることを防ぐため、
        // あり得ない点数の -1 を設定する。
        // （「番兵」と呼ばれる）
        backup[j] = -1;
        break; // 元の順番では、j 番目であったことが分かった
      }
    }
    printf("%d %s\n", score[i], name[j]);
  }

  return 0;
}

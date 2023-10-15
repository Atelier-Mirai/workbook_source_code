#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// 定数定義
#define MAX      3    // 一度に石を取れる最大数
#define PLAYER   0
#define COMPUTER 1

const char *NAMES[] = {"プレーヤー", "コンピュータ"};


// プレーヤーの取った石の数
int capture_stone(char turn, int stone) {
  int n;  // 取る石の数
  switch(turn){
  // プレーヤーの番なら、取りたい個数を入力する
  case PLAYER:
    do {
      printf("石を何個取りますか(1-3)\n");
      scanf("%d", &n);
      while (getchar() != '\n')
        ;
    } while (!(1 <= n && n <= 3 && n <= stone)); // その場にある石の数を超えない
    break;

  // コンピュータの番なら
  case COMPUTER:
    // 4個以下の時には一つ残して取る
    if (stone <= 4) {
      n = stone - 1;
    } else {
      // 乱数で適当に取る
      srand(time(NULL));
      n = rand() % 3 + 1;
    }
    break;
  }

  return n;
}

// 石の表示
void disp_stone(int stone, int stone_max) {
  int i;
  for (i = 1; i <= stone; i++) { printf("●"); }
  for (i = stone + 1; i <= stone_max; i++) { printf("○"); }
  printf("\n");
}

int main(int argc, char const *argv[]) {
  // 変数宣言
  int stone_max;  // 場にある石の最大数
  int stone;      // 場にある石の数
  int n;          // 競技者が取った石の数
  char turn;      // どちらの番か？

  // 乱数で石の総数を決めます
  srand(time(NULL));
  stone_max = rand() % 5 + 20;
  stone     = stone_max;

  // オープニング
  printf("======== 石取りゲーム ========\n");
  printf("交互に１〜３個の石を取ります。\n");
  printf("最後の一個を取ると負けです。\n");
  printf("最初は %d 個の石があります。\n", stone);

  // 先攻後攻
  printf("先攻しますか？ Y/N\n");
  scanf("%c", &turn);
  while (getchar() != '\n')
    ;
  if (turn == 'Y' || turn == 'y') {
    // turn は char型 = -128~127までの整数型 なので、PLAYERを代入できます
    turn = PLAYER;
    printf("プレーヤーの先攻です\n");
  } else {
    turn = COMPUTER;
    printf("コンピュータの先攻です\n");
  }
  printf("\n======== ゲーム開始 ======== \n");

  // 石を交互にとる
  do {
    printf("\n%sの番です\n", NAMES[turn]);
    printf("%d 個の石が残っています\n", stone);
    disp_stone(stone, stone_max);
    n = capture_stone(turn, stone);
    printf("%d 個の石を取りました。\n", n);
    stone -= n;
    turn = (turn+1) % 2;  // 交代
  } while (stone > 0);

  // エンディング
  printf("\n%sの勝ちです\n", NAMES[turn]);
}

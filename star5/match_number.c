/**************************************************************************
 * 数当てゲーム Match Number
 *
 * 事前に用意された３桁の数字を、ヒントをもとに当てていくゲームです。
 * 用意された数字が　９４３ だとします。
 * ９９９と入れると、９は正解ですので、１つ正解と表示します。
 * ３６９と入れると、３と９は正解ですので、２つ正解と表示します。
 * ４３９と入れると、（順番は違いますが）３つとも合っていますので、
 * ３つ正解と表示します。
 * これを繰り返すことで、事前に用意された数字、９４３を当てるゲームです。
 **************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char const *argv[]) {
  int right_number[] = {9, 4, 3}; // 事前に用意された数
                                  // 993 など重複した数は対象外
  char your_number[8];            // 入力された数字
  int number;
  int unique_number[3];           // 重複を除いた数
                                  // 999 の入力なら 9
                                  // 990 の入力なら 9, 0
                                  // 987 の入力なら 9, 8, 7 が入る
  int score;                      // いくつ合っていたか
  int i, j;                       // loop counter

  while(1) {
    printf("三桁の数字を入力して下さい (終了:quit)\n");
    scanf("%s", your_number);
    while (getchar() != '\n')
      ;

    // "quit" が入力されたらプログラム終了
    if (strcmp(your_number, "quit") == 0) {
      break;
    }

    // 入力された文字'n'を数nに変換
    for (i = 0; i < 3; i++) {
      unique_number[i] = your_number[i] - '0';
    }

    // 重複を排除する
    // (990と入力されたならば、90 をMatch Number の対象にする)
    for (i = 2; i >= 1; i--) {    // un[2]は、un[1], un[0]と等しいか？
                                  // un[1]は、un[0]と等しいか？
      for (j = i - 1; j >= 0; j--) {
        if (unique_number[i] == unique_number[j]) {
          unique_number[i] = -1;  // 自分より小さい添字の要素が、
                                  // 自分自身と重複していることが判明したため、
                                  // 未使用の意味で、-1をセットする
        }
      }
    }

    // いくつ合っているか、出力
    score = 0;
    for (i = 0; i < 3; i++) {
      if (unique_number[i] != -1) {
        number = unique_number[i];
      } else {
        break;
      }
      for (j = 0; j < 3; j++) {
        if (number == right_number[j]) {
          score++;
          break;
        }
      }
    }
    printf("正解数: %d \n\n", score);

    // 入力された数値の配列と、正解の配列が等しいことを確認する
    if (unique_number[0] == right_number[0] &&
        unique_number[1] == right_number[1] &&
        unique_number[2] == right_number[2]) {
      // 代えて次のように書くことも出来ます。
      // if(memcmp(unique_number, right_number, sizeof(unique_number)) == 0){
      printf("おめでとうございます。正解です！！\n");
      break;
    }
  } // while end
}

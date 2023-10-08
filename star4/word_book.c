/**************************************************************************
 * 英単語帳アプリを創ってみましょう。
 * I -> わたし
 * love -> 愛する
 * you -> あなた
 * と答えられたら、満点です。
 * 10問出題して、英語力向上を目指しましょう。
 **************************************************************************/

#include "mt.h"
#include <stdio.h>

#define CHOICES_SIZE    3 // 三択で出題する
#define REGISTERD_WORD 10 // 登録単語数
#define TRUE            1 // 真
#define FALSE           0 // 偽

int main(int argc, char const *argv[]) {
  // 出題用配列
  char *english_words[]  = {"",       "I",           "love",    "you",
                            "C",      "language",    "lesson",  "happy",
                            "hacker", "programming", "computer"};
  char *japanese_words[] = {"",       "わたし",         "愛する",      "あなた",
                            "C",      "言語",           "学習",        "幸せ",
                            "技術者", "プログラミング", "コンピュータ"};

  // 三択で出題する
  int choices[CHOICES_SIZE + 1]; // 0 は未使用とするため、+1
  int candidate;                 // 選択肢の候補
  int question_number;           // 第何問目か？
  int correct;                   // 正答
  int answer;                    // 入力された回答
  int score;                     // 得点
  int flag;
  int i;

  // オープニング
  printf("****************************************************\n");
  printf("*                                                   \n");
  printf("*           英単語ゲームへようこそ                  \n");
  printf("*                                                   \n");
  printf("****************************************************\n");
  printf("\n");

  // 出題処理

  // 10題出題する
  score = 0;
  for (question_number = 1; question_number <= 10; question_number++) {
    printf("【第 %d 問】\n", question_number);

    // 選択肢の初期化
    for (i = 0; i <= CHOICES_SIZE; i++) {
      choices[i] = 0;
    }

    // choices[1], [2], [3] に単語番号(添字)をセット
    do {
      // 1から英単語数(REGISTERD_WORD)までの乱数を取得
      candidate = genrand_int32() % REGISTERD_WORD + 1;
      // このcandidate(候補)が、choices(選択肢)に登録済みか調べる。
      int flag = FALSE;
      for (i = 1; i <= CHOICES_SIZE; i++) {
        if (candidate == choices[i]) {
          flag = TRUE; // すでに選ばれていた
          break;
        }
      }
      // 選択肢には未登録であったので、登録する
      if (flag == FALSE) {
        for (i = 1; i <= CHOICES_SIZE; i++) {
          if (choices[i] == 0) {
            // i番目の選択肢として登録する
            choices[i] = candidate;
            break;
          }
        }
      }
      // choice[3]（最後の選択肢）に0以外の値がセットされるまで繰り返す
    } while (choices[CHOICES_SIZE] == 0);

    // choice[1], [2], [3] の中から、いずれかを正解として設定する
    correct = genrand_int32() % 3 + 1;

    // correct を正解として設定したので、
    // choices[correct] の単語を出題する
    printf("%s\n", english_words[choices[correct]]);

    // 選択肢を提示する
    // (choices[correct] の単語が必ず選択肢に含まれている)
    for (i = 1; i <= CHOICES_SIZE; i++) {
      printf("%d: %s ", i, japanese_words[choices[i]]);
    }
    printf("\n");

    // 1 ~ 3 までの入力を求める
    do {
      scanf("%d", &answer);
      while (getchar() != '\n')
        ; // キーバッファ読み飛ばす
    } while (answer <= 0 || answer > CHOICES_SIZE);

    // 正解判定
    if (answer == correct) {
      printf("正解です！\n\n");
      score++; // 得点加算
    } else {
      printf("残念。正解は、%d: %s です。\n\n", correct,
             japanese_words[choices[correct]]);
    }
  }

  // 総合結果発表
  printf("****************************************************\n");
  printf("*                                                   \n");
  printf("*               結　果　発　表                      \n");
  printf("*                                                   \n");
  printf("*             10 問中 %d 問 正解\n", score);
  printf("*                                                   \n");
  printf("*             おめでとうございます！                \n");
  printf("*                                                   \n");
  printf("****************************************************\n");
  printf("\n");

  return 0;
}

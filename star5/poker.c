/*======================================================*/
/*                                                      */
/* ポーカー                                             */
/*                                                      */
/* https://ja.wikipedia.org/wiki/ポーカー・ハンドの一覧 */
/* https://simple.wikipedia.org/wiki/Poker#Hands        */
/*======================================================*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define BUFFER_SIZE 255 // 文字列用のバッファサイズ

// printfを簡単にするためのマクロ定義
#define prd(dt) printf(#dt ":%d\n", dt)
#define prs(dt) printf(#dt ":%s\n", dt)
#define prx(dt) printf(#dt ":%x\n", dt)

// カードの種類
typedef enum { CLUBS = 4, DIAMONDS, HEARTS, SPADES } suits;
typedef enum {
  NO_PAIR,         // 役無し
  ONE_PAIR,        // ワンペア
  TWO_PAIR,        // ツーペア
  THREE_OF_A_KIND, // スリーカード
  STRAIGHT,        // ストレート
  FLUSH,           // フラッシュ
  FULL_HOUSE,      // フルハウス
  FOUR_OF_A_KIND,  // フォーカード
  STRAIGHT_FLUSH,  // ストレートフラッシュ
                   // HANDS_COUNT,      //
} hands_type;

// プロトタイプ宣言
void init_card();
void init_player_hands(char player_hands[3][6]);
void init_score();

void disp_hands();
void disp_score();
void disp_score();

void disp_card(char mycard);

int set_card(char mycard, int player);
void calc_card();
char get_card();
void poker_hands(int player);
int my_random(int n);
void pause();
void usage(char const *argv[]);

int is_no_pair(int player);
int is_one_pair(int player, int seach);
int is_two_pair(int player);
int is_three_of_a_kind(int player);
int is_straight(int player);
int is_flush(int player);
int is_full_house(int player);
int is_four_of_a_kind(int player);
int is_suit(int player, int search);

// 文字コードとビット演算の学習を兼ねて、
// 以下のようにカードを表現する
/***************************************************
 *   A234567890JQK
 * C ABCDEFGHIJKLM
 * D QRSTUVWXYZ[\]
 * H abcdefghijklm
 * S qrstuvwxyz{|}
 *
 * 例）ABCTd と書くと
 * C(クローバー)のA,2,3,
 * D(ダイヤ)の4、
 * H(ハート)の4でワンペア
 ***************************************************/

// player_hands[1]:EJKLM
// player_hands[2]:ejklm
// cards[6][17]
//          | A 2 3 4 5 6 7 8 9 0 J Q K A |  1  2
// ---------+-----------------------------+------
// Clubs    | 0 0 0 0 1 0 0 0 0 1 1 1 1 0 | 13  0
// Diamonds | 0 0 0 0 0 0 0 0 0 0 0 0 0 0 |  0  0
// Hearts   | 0 0 0 0 2 0 0 0 0 2 2 2 2 0 |  0 13
// Spades   | 0 0 0 0 0 0 0 0 0 0 0 0 0 0 |  0  0
// ---------+-----------------------------+------
// Player 1 | 0 0 0 0 1 0 0 0 0 1 1 1 1 0 |  0  0
// Player 2 | 0 0 0 0 1 0 0 0 0 1 1 1 1 0 |  0  0
// プレーヤー1 の役は フラッシュです
// プレーヤー2 の役は フラッシュです

// グローバル変数
char cards[6][17]; // 1-K + A で14種類 player1/2の合計用に2ます追加
                   // 10,J,Q,K,A のストレート判定をしやすくするため、
                   // K の次に Aを設けている
int score[3][10][3]; // 役の強弱を判定するために用いる score[0] 未使用

int main(int argc, char const *argv[]) {
  int i;
  char ss[BUFFER_SIZE + 1]; // ファイルから一行読み込むための作業用
  FILE *fp;                 // ファイルポインタ
  int player;  // １ならプレーヤー１、２ならプレーヤー２
  char mycard; // 一枚引いたカード
  char player_hands[2 + 1][5 + 1]; // プレーヤーの手元にある５枚のカード
                                   // 添字の0は未使用

  // 初期化処理
  init_card();
  init_player_hands(player_hands);
  init_score();

  // コマンドライン引数なしなら、使い方表示して終了
  if (argc < 2) {
    usage(argv);
    exit(1);
  }

  // -f ファイルからの読み取りオプションなら
  if (strcmp(argv[1], "-f") == 0) {
    if ((fp = fopen(argv[2], "r")) == NULL) {
      // エラーメッセージ表示
      printf(" %s を開けませんでした。\n", argv[2]);
      exit(1);
    }

    player = 1;
    while (1) {
      // ファイルから手を読み込む
      fgets(ss, BUFFER_SIZE, fp);
      if (strchr(ss, '*') == NULL && strchr(ss, '/') == NULL) {
        // コメント行でなければ、読み取った手をセットする
        strcpy(player_hands[player], ss);
        player_hands[player][5] = '\0';
        if (player == 2) {
          break;
        } else {
          player++;
        }
      }
    }
    fclose(fp);

    // 各プレーヤーが手にしたカード情報を、カード管理配列へ書き出す
    for (player = 1; player <= 2; player++) {
      for (i = 0; i < 5; i++) {
        mycard = player_hands[player][i];
        // ファイル入力時は、同じカードは所有していないはずなので、
        // エラーチェックはしていない
        set_card(mycard, player);
      }
    }

    // -m 交互入力オプションなら
  } else {
    for (player = 1; player <= 2; player++) {
      for (i = 0; i < 5; i++) {
        do {
          mycard = get_card(); // ランダムにカードを引く
          // prx(mycard);       // 引いたカードを表示(debug)
          disp_card(mycard); // 引いたカードを表示
          pause();
          player_hands[player][i] = mycard;
        } while (set_card(mycard, player) !=
                 0); // 既に引いたカードなら、引き直す
      }
    }
  }

  // playerの手元にあるカードを表示
  prs(player_hands[1]);
  prs(player_hands[2]);

  // 得点計算
  calc_card();

  // 役を計算
  poker_hands(1); // player1 の役を計算
  poker_hands(2); // player2 の役を計算

  // カードの表示
  disp_hands();

  // 得点表示
  disp_score();

  // 役を表示
  for (player = 1; player <= 2; player++) {
    printf("プレーヤー%d の役は ", player);
    switch (score[player][9][0] / 1000) {
    case 8:
      printf("ストレートフラッシュです\n");
      break;
    case 7:
      printf("フォーカードです\n");
      break;
    case 6:
      printf("フルハウスです\n");
      break;
    case 5:
      printf("フラッシュです\n");
      break;
    case 4:
      printf("ストレートです\n");
      break;
    case 3:
      printf("スリーカードです\n");
      break;
    case 2:
      printf("ツーペアです\n");
      break;
    case 1:
      printf("ワンペアです\n");
      break;
    case 0:
      printf("ぶたです\n");
      break;
    }
  }

  // 勝敗表示
  if (score[1][9][0] > score[2][9][0]) {
    printf("プレーヤー1の勝ちです\n");
  } else if (score[1][9][0] < score[2][9][0]) {
    printf("プレーヤー2の勝ちです\n");
  } else {
    printf("引き分けです\n");
  }
  return 0;
}

// カード配列の初期化
void init_card() {
  int i, j;
  for (j = 0; j < 6; j++) {
    for (i = 0; i < 17; i++) {
      cards[j][i] = 0;
    }
  }
}

// 得点配列の初期化
void init_score() {
  int i, j, player;
  for (player = 0; player <= 2; player++) {
    for (i = 0; i < 10; i++) {
      for (j = 0; j < 3; j++) {
        score[player][i][j] = 0;
      }
    }
  }
}

// プレーヤーの手にしているカードの初期化
void init_player_hands(char player_hands[3][6]) {
  int i, j;
  for (j = 0; j < 3; j++) {
    for (i = 0; i < 6; i++) {
      player_hands[j][i] = 0;
    }
  }
}

// カードの表示
void disp_hands() {
  int i, j;
  printf("\n");
  printf("         | A 2 3 4 5 6 7 8 9 0 J Q K A |  1  2 \n");
  printf("---------+-----------------------------+------\n");
  for (j = 0; j < 6; j++) {
    switch (j) {
    case 0:
      printf("Clubs    | ");
      break;
    case 1:
      printf("Diamonds | ");
      break;
    case 2:
      printf("Hearts   | ");
      break;
    case 3:
      printf("Spades   | ");
      break;
    case 4:
      printf("Player 1 | ");
      break;
    case 5:
      printf("Player 2 | ");
      break;
    }
    for (i = 1; i < 17; i++) {
      if (i < 15) {
        printf("%1d ", cards[j][i]);
      } else {
        printf("%2d ", cards[j][i]);
      }
      if (i == 14) {
        printf("| ");
      }
    }
    printf("\n");
    if (j == 3) {
      printf("---------+-----------------------------+------\n");
    }
  }
  printf("\n");
}

// 得点の表示
void disp_score() {
  int i;
  printf("          Player1    Player2\n");
  printf("---------+----------------------------\n");
  for (i = 9; i >= 0; i--) {
    switch (i) {
    case 9:
      printf("<<MAX>>  | ");
      break;
    case 8:
      printf("S.Flush  | ");
      break;
    case 7:
      printf("4 cards  | ");
      break;
    case 6:
      printf("Full H.  | ");
      break;
    case 5:
      printf("Flush    | ");
      break;
    case 4:
      printf("Straight | ");
      break;
    case 3:
      printf("3 cards  | ");
      break;
    case 2:
      printf("2 pair   | ");
      break;
    case 1:
      printf("1 pair   | ");
      break;
    case 0:
      printf("no pair  | ");
      break;
    }
    printf("%4d %3d %3d   %4d %3d %3d\n", score[1][i][0], score[1][i][1],
           score[1][i][2], score[2][i][0], score[2][i][1], score[2][i][2]);
  }
  printf("\n");
}

// カード管理配列へ、プレーヤーの持っているカードを書き出す
int set_card(char mycard, int player) {
  int suits; // 三つ葉、ダイヤ、ハート、スペード
  int rank;  // トランプに書かれている数字

  suits = ((mycard & 0xf0) >> 4) - 4;
  rank = mycard & 0x0f;

  // 例 mycard = 'A' の場合
  // suits = ((mycard & 0xf0) >> 4) - 4;
  // 'A' = 0x41 = 0b0100_0001;
  // 'A' & 0xf0
  // 0x41 & 0xf0
  //    0b0100_0001
  // &) 0b1111_0000
  // --------------
  //    0b0100_0000

  //  0b0100_0000 >> 4 // 右へ４ビットシフト
  //  0b0000_0100
  //  0b0000_0100 - 4 = 0;  // suits = 0となる

  // mycard & 0x0f;
  // 'A' = 0x41 = 0b0100_0001;
  // 'A' & 0x0f
  // 0x41 & 0x0f
  //    0b0100_0001
  // &) 0b0000_1111
  // --------------
  //    0b0000_0001 // 下４ビットを取り出すことが出来た
  // 0b0000_0001 = 1 なので rank(トランプの数字)は１と判明する

  if (cards[suits][rank] == 0) {
    cards[suits][rank] = player;
    if (rank == 1) {
      cards[suits][14] = player; //エースの時
    }
    return 0; //正常終了
  }
  return cards[suits][rank];
  //どのプレーヤーで用いられているか返す
}

// 役の計算
void calc_card() {
  int i, j;
  int sum;
  int player;
  int mul;
  int delta;

  // フラッシュ？
  for (player = 1; player <= 2; player++) {
    for (j = 0; j <= 3; j++) {
      sum = 0;
      for (i = 1; i <= 13; i++) {
        if (cards[j][i] == player) {
          sum += (cards[j][i] / player);
        }
      }
      cards[j][14 + player] = sum;
    }
  }

  for (player = 1; player <= 2; player++) {
    for (j = 0; j <= 3; j++) {
      if (cards[j][14 + player] == 5) {
        for (i = 14; i >= 5; i--) {
          if (cards[j][i] == player) {
            cards[j][14 + player] = i;
            break;
          }
        }
      }
    }
  }

  // ペア？
  for (player = 1; player <= 2; player++) {
    for (j = 1; j <= 14; j++) {
      sum = 0;
      for (i = 0; i <= 3; i++) {
        if (cards[i][j] == player) {
          sum += (cards[i][j] / player);
        }
      }
      cards[3 + player][j] = sum;
    }
  }

  // ストレート？
  for (player = 1; player <= 2; player++) {
    for (delta = 0; delta <= 9; delta++) {
      mul = 1;
      for (i = 1 + delta; i <= 5 + delta; i++) {
        mul *= cards[3 + player][i];
      }
      if (mul != 0) {
        cards[3 + player][14 + player] = --i;
        break;
      }
    }
  }
}

// 役の判定
void poker_hands(int player) {
  int work; // 作業用変数
  int suit;
  int i;

  work = is_four_of_a_kind(player);
  suit = is_suit(player, work);
  score[player][7][1] = work;
  score[player][7][2] = suit;

  work = is_flush(player);
  suit = work % 10;
  score[player][5][1] = work / 10;
  score[player][5][2] = suit;

  work = is_straight(player);
  suit = is_suit(player, work);
  score[player][4][1] = work;
  score[player][4][2] = suit;

  work = is_three_of_a_kind(player);
  suit = is_suit(player, work);
  score[player][3][1] = work;
  score[player][3][2] = suit;

  work = is_two_pair(player);
  suit = is_suit(player, work);
  score[player][2][1] = work;
  score[player][2][2] = suit;

  work = is_one_pair(player, 14);
  suit = is_suit(player, work);
  score[player][1][1] = work;
  score[player][1][2] = suit;

  work = is_no_pair(player);
  suit = is_suit(player, work);
  score[player][0][1] = work;
  score[player][0][2] = suit;

  // フルハウス？
  if (score[player][3][1] != 0 && score[player][1][1] != 0) {
    score[player][6][1] = score[player][3][1];
    score[player][6][2] = score[player][3][2];
  }

  // ストレートフラッシュ？
  if (score[player][4][1] != 0 && score[player][5][1] != 0) {
    score[player][8][1] = score[player][5][1];
    score[player][8][2] = score[player][5][2];
  }

  for (i = 8; i >= 0; i--) {
    score[player][i][0] = score[player][i][1] * 10 + score[player][i][2];
  }

  for (i = 8; i >= 0; i--) {
    if (score[player][i][0] != 0) {
      score[player][9][0] = score[player][i][0] + i * 1000;
      score[player][9][1] = score[player][i][1];
      score[player][9][2] = score[player][i][2];
      break;
    }
  }
}

// フラッシュか判定
int is_flush(int player) {
  int i;
  for (i = 0; i <= 3; i++) {
    if (cards[i][14 + player] >= 5) {
      return cards[i][14 + player] * 10 + i + 1;
    }
  }
  return 0; //フラッシュではなかった
}

// ストレートフラッシュか判定
int is_straight(int player) { return cards[3 + player][14 + player]; }

// フォーカードか判定
int is_four_of_a_kind(int player) {
  int i;
  for (i = 2; i <= 14; i++) {
    if (cards[3 + player][i] == 4) {
      return i;
    }
  }
  return 0;
}

// スリーカードか判定
int is_three_of_a_kind(int player) {
  int i;
  for (i = 2; i <= 14; i++) {
    if (cards[3 + player][i] == 3) {
      return i;
    }
  }
  return 0;
}

// ツーペアか判定
int is_two_pair(int player) {
  int work;
  if ((work = is_one_pair(player, 14)) == 0) {
    return 0;
  }
  if ((is_one_pair(player, work)) == 0) {
    return 0;
  }
  return work;
}

// 10のペアなら10を返す
// ペアが見つからなければ0を返す
int is_one_pair(int player, int search) {
  int i;
  for (i = search; i >= 2; i--) {
    if (cards[3 + player][i] == 2) {
      return i;
    }
  }
  return 0;
}

// ノーペアか判定
int is_no_pair(int player) {
  int i;
  for (i = 14; i >= 2; i--) {
    if (cards[3 + player][i] == 1) {
      return i;
    }
  }
  return 0; // error
}

// rank == 13の時、13は何のマークかを返す
int is_suit(int player, int rank) {
  int i;
  for (i = 3; i >= 0; i--) {
    if (cards[i][rank] == player) {
      return i + 1;
    }
  }
  return 0; // rankの数のカードは持っていない
}

// アスキーアートでカードを表示
void disp_card(char mycard) {
  int suits; // 三つ葉、ダイヤ、ハート、スペード
  char rank; // トランプに書かれている数字

  suits = (mycard & 0xf0) >> 4;
  rank = mycard & 0x0f;
  switch (rank) {
  case 1:
    rank = 'A';
    break;
  case 11:
    rank = 'J';
    break;
  case 12:
    rank = 'Q';
    break;
  case 13:
    rank = 'K';
    break;
  }
  // printf("mycard: %x suits: %x, rank: %x\n", mycard, suits, rank);

  switch (suits) {
  case CLUBS:
    if (2 <= rank && rank <= 10) {
      printf("      ∩  \n");
      printf("   （　） \n");
      printf("  ／ %2d ＼\n", rank);
      printf("⊂__________⊃\n");
      printf("      ∧      \n");
      printf("    ／＿＼    \n");
    } else {
      printf("      ∩  \n");
      printf("   （　） \n");
      printf("  ／  %c ＼\n", rank);
      printf("⊂__________⊃\n");
      printf("      ∧      \n");
      printf("    ／＿＼    \n");
    }
    break;
  case DIAMONDS:
    if (2 <= rank && rank <= 10) {
      printf("     ／＼    \n");
      printf("   ／　　＼  \n");
      printf(" ／　　　　＼\n");
      printf(" ＼　 %2d 　／\n", rank);
      printf("   ＼　　／  \n");
      printf("     ＼／    \n");
    } else {
      printf("     ／＼    \n");
      printf("   ／　　＼  \n");
      printf(" ／　　　　＼\n");
      printf(" ＼　 %c 　／\n", rank);
      printf("   ＼　　／  \n");
      printf("     ＼／    \n");
    }
    break;
  case HEARTS:
    if (2 <= rank && rank <= 10) {
      printf(" ／￣＼／￣＼\n");
      printf("｜　　　　　｜\n");
      printf(" ＼　 %2d 　／\n", rank);
      printf("   ＼　　／  \n");
      printf("     ＼／    \n");
      printf("             \n");
    } else {
      printf(" ／￣＼／￣＼\n");
      printf("｜　　　　　｜\n");
      printf(" ＼　 %c  　／\n", rank);
      printf("   ＼　　／  \n");
      printf("     ＼／    \n");
      printf("             \n");
    }
    break;
  case SPADES:
    if (2 <= rank && rank <= 10) {
      printf("     ／＼    \n");
      printf("   ／　　＼  \n");
      printf(" ／　　　　＼\n");
      printf("｜　　%2d　　｜\n", rank);
      printf(" ＼＿    ＿／  \n");
      printf("    ／＿＼     \n");
    } else {
      printf("     ／＼    \n");
      printf("   ／　　＼  \n");
      printf(" ／　　　　＼\n");
      printf("｜　　%c 　　｜\n", rank);
      printf(" ＼＿    ＿／  \n");
      printf("    ／＿＼     \n");
    }
    break;
  }
}

/* 0-n未満の数を返す */
int my_random(int n) { return clock() % n; }

// カードをランダムに引く
char get_card() {
  int suits; // 三つ葉、ダイヤ、ハート、スペード
  int rank;  // トランプに書かれている数字

  suits = my_random(4);
  rank = my_random(13) + 1;
  return ((suits + 4) << 4) + rank;
}

// 一時停止
void pause() {
  printf(" === press return key === ");
  while (getchar() != '\n')
    ;
}

// 使い方表示
void usage(char const *argv[]) {
  printf(" --- 使い方 --- \n");
  printf("1)");
  printf("%s -f filename\n", argv[0]);
  printf("指定されたファイルからplayer1, player2の手を読み込みます\n");
  printf("\n");
  printf("2)");
  printf("%s -m\n", argv[0]);
  printf("交互にランダムでカードを引きます\n");
  printf("\n");
}

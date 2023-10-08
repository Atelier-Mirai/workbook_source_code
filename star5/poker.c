/**************************************************************************/
//
// ポーカー
//
// https://ja.wikipedia.org/wiki/ポーカー
// https://ja.wikipedia.org/wiki/ポーカー・ハンドの一覧
//
// 文字コードとビット演算の学習を兼ねて、次のようにカードを表現します。
//
// ASCIIコード表(抜粋)
//      |123456789ABCD
// -----+-------------
// 0x40 |ABCDEFGHIJKLM
// 0x50 |QRSTUVWXYZ[\]
// 0x60 |abcdefghijklm
// 0x70 |qrstuvwxyz{|}
//
// 文字'A'の文字コードは0x41です。
// 上位4bitでカードの種類(suits) を、
// 下位4bitでカードの数字(rank)を、表現することとします。
// するとトランプカード一式は次のように表現できます。
//
// カードの表現
//          |A234567890JQK
// ---------+-------------
// ♣️Club   |ABCDEFGHIJKLM
// ♦︎Diamond|QRSTUVWXYZ[\]
// ♡Heart  |abcdefghijklm
// ♠️Spade  |qrstuvwxyz{|}
//
// 例）Cards と書くと
// Cは Club(三つ葉)の3
// aは Heart(ハート)のA
// rは Spade(スペード)の2
// dは Heart(ハート)の4
// sは Spade(スペード)の3 を表すので
// ワンペアとなります。
//
// プレイヤーの手札は文字型の配列で表現します。
// hands[1]:EJKLM
// hands[2]:ejklm
//
// また、役の判定を行いやすくするために、次のような管理配列を用意します。
// cards[6][17]
//          | A 2 3 4 5 6 7 8 9 0 J Q K A | P1 P2
// ---------+-----------------------------+------
// Clubs    | 0 0 0 0 1 0 0 0 0 1 1 1 1 0 |  5  0
// Diamonds | 0 0 0 0 0 0 0 0 0 0 0 0 0 0 |  0  0
// Hearts   | 0 0 0 0 2 0 0 0 0 2 2 2 2 0 |  0  5
// Spades   | 0 0 0 0 0 0 0 0 0 0 0 0 0 0 |  0  0
// ---------+-----------------------------+------
// Player 1 | 0 0 0 0 1 0 0 0 0 1 1 1 1 0 |  0  0
// Player 2 | 0 0 0 0 1 0 0 0 0 1 1 1 1 0 |  0  0
//
// この場合、プレーヤー1は三つ葉を5枚、プレーヤー2はハートを5枚持っています。
// ですので、どちらの役もフラッシュです。
/**************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

// 文字列用のバッファサイズ
#define BUFFER_SIZE 255
// デバッグを簡単にするためのマクロ定義
#define p(var) printf(#var ":%s\n", var)

// カードの種類
typedef enum {
  CLUBS = 4,
  DIAMONDS,
  HEARTS,
  SPADES
} suits;

// 役の種類
typedef enum {
  NO_PAIR,         // 0 ぶた
  ONE_PAIR,        // 1 ワンペア
  TWO_PAIR,        // 2 ツーペア
  THREE_OF_A_KIND, // 3 スリーカード
  STRAIGHT,        // 4 ストレート
  FLUSH,           // 5 フラッシュ
  FULL_HOUSE,      // 6 フルハウス
  FOUR_OF_A_KIND,  // 7 フォーカード
  STRAIGHT_FLUSH,  // 8 ストレートフラッシュ
  TOTAL_SCORE,     // 9 役判定後の合計得点
} hands_type;

// 役の名称
const char* HANDS_NAME[9] = {
  "ぶた",
  "ワンペア",
  "ツーペア",
  "スリーカード",
  "ストレート",
  "フラッシュ",
  "フルハウス",
  "フォーカード",
  "ストレートフラッシュ",
};

// プロトタイプ宣言
// 初期化
void init_cards();
void init_hands();
void init_scores();

// 表示用
void disp_cards();
void disp_scores();
void draw_ascii_art(char mycard);

// 処理用
int  set_card(char mycard, int player);
void calc_cards();
char get_card();
void calc_hands();
int  my_random(int n);
void pause();
void usage(char const *argv[]);

// 役判定用
int is_no_pair(int player);
int is_one_pair(int player);
int is_two_pair(int player);
int is_three_of_a_kind(int player);
int is_straight(int player);
int is_flush(int player);
int is_four_of_a_kind(int player);
int get_suit(int player, int rank);

// グローバル変数
char hands[2+1][5+1];     // プレーヤーの手元にある5枚のカードを保持する配列
                          // 添字の0は未使用
char cards[4+2][14+2+1];  // カード管理用配列
                          // 10,J,Q,K,A のストレート判定の為
                          // K の次にも Aを設けることで、14要素
                          // Player1, 2の合計用に 2要素追加し
                          // 添字0は未使用の為、17要素とする
int scores[2+1][9+1][2+1];// 役を点数に変換、強弱を判定するために用いる配列
                          // 添字の0は未使用

/*---------------------------------------------------------------------
// メイン関数
---------------------------------------------------------------------*/
int main(int argc, char const *argv[]) {
  int  n;                    // n枚目の手札
  char str[BUFFER_SIZE + 1]; // ファイルから一行読み込むための作業用
  FILE *fp;                  // ファイルポインタ
  int  player;               // 1ならプレーヤー1、2ならプレーヤー2を示す
  char mycard;               // 一枚場から引いたカード

  // 初期化処理
  init_cards();
  init_hands();
  init_scores();

  // コマンドライン引数無しなら、使い方表示して終了
  if (argc < 2) {
    usage(argv);
    exit(0);
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
      fgets(str, BUFFER_SIZE, fp);
      // コメント行('*'や'/'を含む行)でなければ、
      if (strchr(str, '*') == NULL && strchr(str, '/') == NULL) {
        // 読み取った手をセットする
        strcpy(hands[player], str);
        hands[player][5] = '\0';
        if (player == 1) {
          player++;
        } else {
          break;
        }
      }
    }
    fclose(fp);

    // 各プレーヤーが手にしたカード情報を、カード管理配列へ書き出す
    for (player = 1; player <= 2; player++) {
      // 0枚目から4枚目までのカードを順にセットする
      for (n = 0; n < 5; n++) {
        mycard = hands[player][n];
        // ファイル入力時は、同じカードは所有していないはずなので、
        // エラーチェックはしていない
        set_card(mycard, player);
      }
    }

  // -m 交互入力オプションなら
  } else {
    for (player = 1; player <= 2; player++) {
      // 0枚目から4枚目までのカードを場から順に引く
      for (n = 0; n < 5; n++) {
        do {
          mycard = get_card();        // ランダムにカードを引く
          draw_ascii_art(mycard);     // 引いたカードをアスキーアートで表示
          pause();                    // 一時停止
          hands[player][n] = mycard;  // 手札配列にセット
        } while (set_card(mycard, player) != 0); // 既出のカードなら引き直す
      }
    }
  }

  // 各playerの手元にあるカードを表示
  p(hands[1]);
  p(hands[2]);

  // 得点計算
  calc_cards();

  // 役を計算
  calc_hands();

  // カード管理配列の表示
  disp_cards();

  // 得点表示
  disp_scores();

  // 役を表示
  for (player = 1; player <= 2; player++) {
    int h = scores[player][TOTAL_SCORE][0] / 1000;
    printf("プレーヤー%d の役は %s です\n", player, HANDS_NAME[h]);
  }

  // 勝敗表示
  if (scores[1][TOTAL_SCORE][0] > scores[2][TOTAL_SCORE][0]) {
    printf("プレーヤー1の勝ちです\n");
  } else if (scores[1][TOTAL_SCORE][0] < scores[2][TOTAL_SCORE][0]) {
    printf("プレーヤー2の勝ちです\n");
  } else {
    printf("引き分けです\n");
  }
  return 0;
}

/*---------------------------------------------------------------------
// カード配列の初期化
---------------------------------------------------------------------*/
void init_cards() {
  int rank, suit;
  for (suit = 0; suit < 6; suit++) {
    for (rank = 0; rank < 17; rank++) {
      cards[suit][rank] = 0;
    }
  }
}

/*---------------------------------------------------------------------
// 得点配列の初期化
---------------------------------------------------------------------*/
void init_scores() {
  int hand, attr, player;
  for (player = 0; player <= 2; player++) {
    for (hand = NO_PAIR; hand <= TOTAL_SCORE; hand++) {
      for (attr = 0; attr < 3; attr++) {
        scores[player][hand][attr] = 0;
      }
    }
  }
}

/*---------------------------------------------------------------------
// プレーヤーの手にしているカードの初期化
---------------------------------------------------------------------*/
void init_hands() {
  int player, n;
  for (player = 0; player <= 2; player++) {
    for (n = 0; n <= 5; n++) {
      hands[player][n] = 0;
    }
  }
}

/*---------------------------------------------------------------------
// カードの表示
---------------------------------------------------------------------*/
void disp_cards() {
  int suit, rank;
  printf("\n");
  printf("         | A 2 3 4 5 6 7 8 9 0 J Q K A | P1 P2\n");
  printf("---------+-----------------------------+------\n");
  for (suit = 0; suit < 6; suit++) {
    switch (suit) {
    case 0:
      printf("Clubs    | ");      break;
    case 1:
      printf("Diamonds | ");      break;
    case 2:
      printf("Hearts   | ");      break;
    case 3:
      printf("Spades   | ");      break;
    case 4:
      printf("Player 1 | ");      break;
    case 5:
      printf("Player 2 | ");      break;
    }
    for (rank = 1; rank < 17; rank++) {
      printf("%1d ", cards[suit][rank]);
      if (rank == 14) {
        printf("| ");
      }
    }
    printf("\n");
    if (suit == 3) {
      printf("---------+-----------------------------+------\n");
    }
  }
  printf("\n");
}

/*---------------------------------------------------------------------
// 得点の表示
---------------------------------------------------------------------*/
void disp_scores() {
  int hand;
  printf("               Player1              Player2     \n");
  printf("            Score suit rank      Score suit rank\n");
  printf("---------+--------------------------------------\n");
  for (hand = TOTAL_SCORE; hand >= NO_PAIR; hand--) {
    switch (hand) {
    case TOTAL_SCORE:
      printf("= TOTAL =| "); break;
    case STRAIGHT_FLUSH:
      printf("S.Flush  | "); break;
    case FOUR_OF_A_KIND:
      printf("4 cards  | "); break;
    case FULL_HOUSE:
      printf("Full H.  | "); break;
    case FLUSH:
      printf("Flush    | "); break;
    case STRAIGHT:
      printf("Straight | "); break;
    case THREE_OF_A_KIND:
      printf("3 cards  | "); break;
    case TWO_PAIR:
      printf("2 pair   | "); break;
    case ONE_PAIR:
      printf("1 pair   | "); break;
    case NO_PAIR:
      printf("no pair  | "); break;
    }
    printf("%5d %5d %5d   %5d %5d %5d\n",
           scores[1][hand][0], scores[1][hand][2], scores[1][hand][1],
           scores[2][hand][0], scores[2][hand][2], scores[2][hand][1]);
  }
  printf("\n");
}

/*---------------------------------------------------------------------
// カード管理配列へ、プレーヤーの持っているカードをセットする
---------------------------------------------------------------------*/
int set_card(char mycard, int player) {
  int suit;  // 三つ葉、ダイヤ、ハート、スペード
  int rank;  // トランプに書かれている数字

  suit = ((mycard & 0xf0) >> 4) - 4;
  rank =  (mycard & 0x0f);

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
  //    0b0000_0001 = 1 なので rank(トランプの数字)は１と判明する

  // まだどのプレーヤーの手札にもなっていなければ
  if (cards[suit][rank] == 0) {
    // playerの手札になっている旨、セットする
    cards[suit][rank] = player;
    if (rank == 1) {
      cards[suit][14] = player; //エースの時
    }
    return 0; //正常終了
  } else {
    // 既にいずれかのプレーヤーの手札になっているならば
    return cards[suit][rank]; //どのプレーヤーで用いられているか返す
  }
}

/*---------------------------------------------------------------------
// cards配列内の縦横集計を行う
//          | A 2 3 4 5 6 7 8 9 0 J Q K A | P1 P2
// ---------+-----------------------------+------
// Clubs    | 0 0 0 0 0 0 0 0 0 1 1 1 1 0 |  5  0
// Diamonds | 0 0 0 0 0 0 0 0 0 0 0 0 1 0 |  0  0
// Hearts   | 2 0 0 0 0 0 0 0 0 2 2 2 2 2 |  0  5 <- Player2が5枚の
// Spades   | 0 0 0 0 0 0 0 0 0 0 0 0 0 0 |  0  0    ♡所持を示す
// ---------+-----------------------------+------
// Player 1 | 0 0 0 0 0 0 0 0 0 1 1 1 2 0 |  0  0
// Player 2 | 1 0 0 0 0 0 0 0 0 1 1 1 1 1 |  0 14 <- Player2は 14(=A)から
                                      ^              始まるフラッシュを意味する
                                      |___ Player1は2枚のK所持を示す
---------------------------------------------------------------------*/
void calc_cards() {
  int rank;
  int suit;
  int sum;
  int player;
  int range;

  // フラッシュか判定できるよう、右端集計欄に書き込む
  for (player = 1; player <= 2; player++) {
    for (suit = 0; suit <= 3; suit++) {
      sum = 0;
      for (rank = 1; rank <= 13; rank++) {
        if (cards[suit][rank] == player) {
          sum += (cards[suit][rank] / player);
        }
      }
      cards[suit][14 + player] = sum;
    }
  }

  // フラッシュだった場合、右下隅に最高rankを書き込む
  for (player = 1; player <= 2; player++) {
    for (suit = 0; suit <= 3; suit++) {
      if (cards[suit][14 + player] == 5) {
        for (rank = 14; rank >= 5; rank--) {
          if (cards[suit][rank] == player) {
            cards[suit][14 + player] = rank;
            break;
          }
        }
      }
    }
  }

  // 1ペア〜4ペアまで判定しやすいよう、下の合計欄に書き込む
  for (player = 1; player <= 2; player++) {
    for (rank = 1; rank <= 14; rank++) {
      sum = 0;
      for (suit = 0; suit <= 3; suit++) {
        if (cards[suit][rank] == player) {
          sum += (cards[suit][rank] / player);
        }
      }
      cards[3 + player][rank] = sum;
    }
  }

  // ストレートだった場合、右下隅に最高rankを書き込む
  for (player = 1; player <= 2; player++) {
    for (rank = 10; rank >= 1; rank--) {
      sum = 0;
      // 11111と 連続する5つの範囲の合計を取る
      for (range = 4; range >=0; range--) {
        if (cards[3 + player][rank + range] == 1) {
          sum += cards[3 + player][rank + range];
        }
      }
      if (sum == 5) {
        cards[3 + player][14 + player] = rank + 4;
        break;
      }
    }
  }
}

/*---------------------------------------------------------------------
// 役が成立しているか確認し、scores配列へ結果を書き込む
---------------------------------------------------------------------*/
void calc_hands() {
  int rank;
  int suit;
  int player;
  int hand;

  for (player = 1; player <= 2; player++) {
    rank = is_four_of_a_kind(player);
    suit = get_suit(player, rank);
    scores[player][FOUR_OF_A_KIND][1] = rank;
    scores[player][FOUR_OF_A_KIND][2] = suit;

    rank = is_flush(player);
    suit = rank % 10;
    scores[player][FLUSH][1] = rank / 10;
    scores[player][FLUSH][2] = suit;

    rank = is_straight(player);
    suit = get_suit(player, rank);
    scores[player][STRAIGHT][1] = rank;
    scores[player][STRAIGHT][2] = suit;

    rank = is_three_of_a_kind(player);
    suit = get_suit(player, rank);
    scores[player][THREE_OF_A_KIND][1] = rank;
    scores[player][THREE_OF_A_KIND][2] = suit;

    rank = is_two_pair(player);
    suit = get_suit(player, rank);
    scores[player][TWO_PAIR][1] = rank;
    scores[player][TWO_PAIR][2] = suit;

    rank = is_one_pair(player);
    suit = get_suit(player, rank);
    scores[player][ONE_PAIR][1] = rank;
    scores[player][ONE_PAIR][2] = suit;

    rank = is_no_pair(player);
    suit = get_suit(player, rank);
    scores[player][NO_PAIR][1] = rank;
    scores[player][NO_PAIR][2] = suit;

    // フルハウス？
    if (scores[player][THREE_OF_A_KIND][1] != 0 && scores[player][ONE_PAIR][1] != 0) {
      scores[player][FULL_HOUSE][1] = scores[player][THREE_OF_A_KIND][1];
      scores[player][FULL_HOUSE][2] = scores[player][THREE_OF_A_KIND][2];
    }

    // ストレートフラッシュ？
    if (scores[player][STRAIGHT][1] != 0 && scores[player][FLUSH][1] != 0) {
      scores[player][STRAIGHT_FLUSH][1] = scores[player][FLUSH][1];
      scores[player][STRAIGHT_FLUSH][2] = scores[player][FLUSH][2];
    }

    for (hand = STRAIGHT_FLUSH; hand >= NO_PAIR; hand--) {
      // 十の位はrank, 一の位はsuitとすることで、
      // 同じランクであっても、大小関係から強弱を判定できる
      scores[player][hand][0] = scores[player][hand][1] * 10 + scores[player][hand][2];
    }

    for (hand = STRAIGHT_FLUSH; hand >= NO_PAIR; hand--) {
      if (scores[player][hand][0] != 0) {
        scores[player][TOTAL_SCORE][0] = scores[player][hand][0] + hand * 1000;
        scores[player][TOTAL_SCORE][1] = scores[player][hand][1];
        scores[player][TOTAL_SCORE][2] = scores[player][hand][2];
        break;
      }
    }
  }
}

/*---------------------------------------------------------------------
// フラッシュか判定
---------------------------------------------------------------------*/
int is_flush(int player) {
  int suit;
  for (suit = 0; suit <= 3; suit++) {
    if (cards[suit][14 + player] >= 5) {
      return cards[suit][14 + player] * 10 + suit + 1;
    }
  }
  return 0; //フラッシュではなかった
}

/*---------------------------------------------------------------------
// ストレートか判定 rankを返す
---------------------------------------------------------------------*/
int is_straight(int player) {
  // calc_cards で計算済みなので、値を返すのみ
  return cards[3 + player][14 + player];
}

/*---------------------------------------------------------------------
// フォーカードか判定 rankを返す
---------------------------------------------------------------------*/
int is_four_of_a_kind(int player) {
  int rank;
  for (rank = 14; rank >= 2; rank--) {
    if (cards[3 + player][rank] == 4) {
      return rank;
    }
  }
  return 0;
}

/*---------------------------------------------------------------------
// スリーカードか判定 rankを返す
---------------------------------------------------------------------*/
int is_three_of_a_kind(int player) {
  int rank;
  for (rank = 14; rank >= 2; rank--) {
    if (cards[3 + player][rank] == 3) {
      return rank;
    }
  }
  return 0;
}

/*---------------------------------------------------------------------
// ツーペアか判定 rankを返す
---------------------------------------------------------------------*/
int is_two_pair(int player) {
  int rank;
  int max_rank = 0; // 発見したツーペアの内、ランクの高いもの
  int count = 0;    // 発見したワンペアの数
  for (rank = 14; rank >= 2; rank--) {
    if (cards[3 + player][rank] == 2) {
      if (max_rank < rank) {
        max_rank = rank;
      }
      count++;
    }
  }

  // ツーペアならば
  if (count == 2) {
    return max_rank;
  }
  return 0;
}

/*---------------------------------------------------------------------
// ワンペアか判定 rankを返す
---------------------------------------------------------------------*/
int is_one_pair(int player) {
  int rank;
  for (rank = 14; rank >= 2; rank--) {
    if (cards[3 + player][rank] == 2) {
      return rank;
    }
  }
  return 0;
}

/*---------------------------------------------------------------------
// ノーペアか判定
---------------------------------------------------------------------*/
int is_no_pair(int player) {
  int rank;
  for (rank = 14; rank >= 2; rank--) {
    if (cards[3 + player][rank] == 1) {
      return rank;
    }
  }
  return 0; // error
}

/*---------------------------------------------------------------------
// 何のマークか？
// rank == 13の時、13は何のマークかを返す
---------------------------------------------------------------------*/
int get_suit(int player, int rank) {
  int i;
  for (i = 3; i >= 0; i--) {
    if (cards[i][rank] == player) {
      return i + 1;
    }
  }
  return 0; // rankの数のカードは持っていない
}

/*---------------------------------------------------------------------
// アスキーアートでカードを表示
---------------------------------------------------------------------*/
void draw_ascii_art(char mycard) {
  int  suit;  // 三つ葉、ダイヤ、ハート、スペード
  char rank;  // トランプに書かれている数字

  suit = (mycard & 0xf0) >> 4;
  rank = (mycard & 0x0f);

  switch (rank) {
  case 11: rank = 'J'; break;
  case 12: rank = 'Q'; break;
  case 13: rank = 'K'; break;
  case 14: rank = 'A'; break;
  case  1: rank = 'A'; break;
  }

  switch (suit) {
  case CLUBS:
    if (2 <= rank && rank <= 10) {
      printf("      ∩      \n");
      printf("    （　）    \n");
      printf("   ／ %2d ＼  \n", rank);
      printf("⊂__________⊃\n");
      printf("      ∧      \n");
      printf("    ／＿＼    \n");
    } else {
      printf("      ∩      \n");
      printf("    （　）    \n");
      printf("   ／  %c ＼   \n", rank);
      printf("⊂__________⊃\n");
      printf("      ∧      \n");
      printf("    ／＿＼    \n");
    }
    break;
  case DIAMONDS:
    if (2 <= rank && rank <= 10) {
      printf("     ／＼     \n");
      printf("   ／　　＼   \n");
      printf(" ／　 %2d　 ＼\n", rank);
      printf(" ＼　     　／\n");
      printf("   ＼　　／   \n");
      printf("     ＼／     \n");
    } else {
      printf("     ／＼     \n");
      printf("   ／　　＼   \n");
      printf(" ／　  %c　 ＼ \n", rank);
      printf(" ＼　     　／\n");
      printf("   ＼　　／   \n");
      printf("     ＼／     \n");
    }
    break;
  case HEARTS:
    if (2 <= rank && rank <= 10) {
      printf(" ／￣＼／￣＼ \n");
      printf("｜　　　　　｜\n");
      printf("｜　  %2d  　｜\n", rank);
      printf(" ＼　     　／\n");
      printf("   ＼　　／   \n");
      printf("     ＼／     \n");
    } else {
      printf(" ／￣＼／￣＼ \n");
      printf("｜　　　　　｜\n");
      printf("｜　   %c  　｜\n", rank);
      printf(" ＼　     　／\n");
      printf("   ＼　　／   \n");
      printf("     ＼／     \n");
    }
    break;
  case SPADES:
    if (2 <= rank && rank <= 10) {
      printf("     ／＼      \n");
      printf("   ／　　＼    \n");
      printf(" ／　 %2d 　＼  \n", rank);
      printf("｜　　  　　｜\n");
      printf(" ＼＿    ＿／  \n");
      printf("    ／＿＼     \n");
    } else {
      printf("     ／＼      \n");
      printf("   ／　　＼    \n");
      printf(" ／　  %c 　＼ \n", rank);
      printf("｜　　  　　｜ \n");
      printf(" ＼＿    ＿／  \n");
      printf("    ／＿＼     \n");
    }
    break;
  }
}

/*---------------------------------------------------------------------
// 0-n未満の数を返す
---------------------------------------------------------------------*/
int my_random(int n) {
  return clock() % n;
}

/*---------------------------------------------------------------------
// カードをランダムに引く
---------------------------------------------------------------------*/
char get_card() {
  int suit; // 三つ葉、ダイヤ、ハート、スペード
  int rank; // トランプに書かれている数字

  suit = my_random(4);
  rank = my_random(13) + 1;
  return ((suit + 4) << 4) + rank;
}

/*---------------------------------------------------------------------
// 一時停止
---------------------------------------------------------------------*/
void pause() {
  printf("\n === press return key === \n");
  while (getchar() != '\n')
    ;
}

/*---------------------------------------------------------------------
// 使い方表示
---------------------------------------------------------------------*/
void usage(char const *argv[]) {
  printf(" --- 使い方 --- \n");
  printf("1) %s -f cards.txt\n", argv[0]);
  printf("指定されたファイル cards.txt からプレーヤーの手を読み込みます\n");
  printf("\n");
  printf("2) %s -m\n", argv[0]);
  printf("交互にランダムでカードを引きます\n");
  printf("\n");
}

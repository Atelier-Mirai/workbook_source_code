/**************************************************************************
 * 連結リスト
 * https://ja.wikipedia.org/wiki/連結リスト
 *
 * マージソート
 * https://ja.wikipedia.org/wiki/マージソート
 * https://programming-place.net/ppp/contents/algorithm/sort/007.html
 **************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include "linked_list.h"

// 関数プロトタイプ宣言
list_t *merge(list_t *a, list_t *b);
list_t *merge_sort(list_t *list);
// void merge_sort(list_t *list);

int main(int argc, char const *argv[]) {
  // 線形リスト宣言と、一番最初のノード生成
  list_t *list = (list_t *)malloc(sizeof(list_t));

  // このリストにあるノードは一つだけで、
  // 次の要素はまだ空なのでNULLを入れる（番兵）
  list->next  = NULL;
  list->value = 0;

  // 初期値投入
  insert_node(list, 3);
  insert_node(list, 14);
  insert_node(list, 15);
  insert_node(list, 92);
  insert_node(list, 65);
  insert_node(list, 35);
  insert_node(list, 89);
  insert_node(list, 79);
  insert_node(list, 24);
  insert_node(list, 58);

  // リストの表示
  printf("並び替え前\n");
  show_list(list);

  // マージソート実行
  merge_sort(list);

  // リストの表示
  printf("並び替え後\n");
  show_list(list);

  // リストの解放
  release_list(list);

  return 0;
}

// 二つのリストを併合（マージ）する
list_t *merge(list_t *a, list_t *b) {
  list_t result;        // 併合されたリスト
  list_t *w = &result;  // work 変数
                        // これを起点に、a, b 小さい方を順に連結していく

  // リストをマージ
  while (a != NULL && b != NULL) {
    // 昇順ソートのため、小さい要素を先にする。
    // a と b が等しい場合は、先頭を優先すると安定ソートとなる。
    if (a->value <= b->value) {
      w->next = a;        // wの後ろにaを連結する
      w       = w->next;  // aを連結したので、さらに小さい数を連結できるよう
                          // 次のノードに進む
      a       = a->next;  // a の次のノードに進む
    } else {
      w->next = b;
      w       = w->next;
      b       = b->next;
    }
  }

  // 残っている要素を、末尾へ連結
  if (a == NULL) {
    // a が短かったということなので、余っているbのノードを繋ぐ
    w->next = b;
  } else {
    w->next = a;
  }

  // 併合されたリストを返す
  return result.next;
}

// リストを二分割し、再帰的にマージする
list_t *merge_sort(list_t *list) {
  // 動作確認用
  list_t *a;
  list_t *b;
  list_t *w; // work 変数

  // 要素が0又は1であれば終了
  if (list == NULL || list->next == NULL) {
    return list;
  }

  // ２つのリストに分割するため、リストの中心を探す。
  // a はリストの先頭を指し、b はリストの二番目のノードを指す。
  // a が一つ進む間に、b は二つ進むので、
  // b がリストの末尾に辿り着いた時には、
  // a は リストのちょうど中央を指している。
  a = list;
  b = list->next;
  if (b != NULL) {
    b = b->next;
  }
  while (b != NULL) {
    a = a->next;
    b = b->next;
    if (b != NULL) {
      b = b->next;
    }
  }

  // 動作確認用
  // printf("------- a ------- \n");
  // show_list(a);

  // リストを前半と後半に分離する
  // a は リスト中央を指しているので、
  // a->next = NULL とすると list が 前半部分のみになる。
  // この時、後半の始まりが失われないよう、work変数に記憶しておく。
  w = a->next;
  a->next = NULL;

  // 動作確認用
  // printf("------- list ------- \n");
  // show_list(list);

  // 前半と後半のリストを、再帰的にマージする。
  return merge(merge_sort(list), merge_sort(w));
}

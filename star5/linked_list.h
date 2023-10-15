#define NOT_FOUND -1
#define SUCCESS    1
#define FAIL       0

// リスト用構造体定義
typedef struct list {
  struct list *next;
  int value;
} list_t;

// ノードの挿入
int insert_node(list_t *list, int number) {
  // 新規確保用
  list_t *p;
  // 次のノードへのポインタ
  list_t *next;
  // 先頭から順にたどってきた最後のノード
  list_t *last;

  // 新しいリストの領域を確保
  p = (list_t *)malloc(sizeof(list_t));

  // メモリ確保に失敗
  if (p == NULL) {
    return FAIL;
  }

  // 値を代入
  p->value = number;
  // 次の要素は末尾と分かるようにNULLを入れる。（番兵）
  p->next = NULL;

  // 先頭が末尾直前のポインタになる
  last = list;

  // 先頭ノードから順に末尾のノードまで移動
  for (next = (*list).next; next != NULL; next = next->next) {
    last = next;
  }

  // リストを連結する。
  last->next = p;

  return SUCCESS;
}

// ノードの削除
int remove_node(list_t *list, int number) {
  list_t *p;

  // 削除要素の直前のノードへのポインタ
  list_t *prev;

  // 最初は先頭要素の次のリストからチェックしてるので、
  // 削除要素の直前の要素は先頭要素になる。
  prev = list;

  // リストを末尾(NULLになる)までループ
  for (p = (*list).next; p != NULL; p = p->next) {
    // その値があれば
    if (p->value == number) {
      // 削除要素の前のリストにつなげる
      // 次の要素が末尾(NULL)なら、つなげる必要がないので事前にチェック
      if (p->next != NULL) {
        // 削除直前の要素につなげる
        prev->next = p->next;
        // 削除対象要素の解放
        free(p);
        return SUCCESS;
      }
      // 削除要素が末尾の要素だった場合の処理
      // 末尾要素にNULLを入れる
      prev->next = NULL;

      // 削除対象要素の解放
      free(p);
      return SUCCESS;
    }
    prev = p;
  }
  return NOT_FOUND;
}

// リストの表示
int show_list(list_t *list) {
  if ((*list).next == NULL) {
    return NOT_FOUND;
  }

  // NULLになるまで全部表示
  list_t *p;
  for (p = (*list).next; p != NULL; p = p->next) {
    printf("%d ", p->value);
  }
  printf("\n");

  return SUCCESS;
}

// リストの解放
void release_list(list_t *list) {
  // 次のリストのポインタ
  list_t *next;
  // 削除対象のポインタ
  list_t *delete_node;
  next = (*list).next;

  // NULLになるまでループ
  while (next) {
    // 削除対象のポインタを保存
    delete_node = next;
    // 次のリストのポインタを取得
    next = next->next;
    free(delete_node);
  }
}

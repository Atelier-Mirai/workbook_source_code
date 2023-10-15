#include <stdio.h>

int main(int argc, char const *argv[]) {
  int vegetable;  // 野菜を食べた量
  int total = 0;  // 今まで食べた量の合計
  int ratio;      // 率
  int goal = 350; // 目標
  int n;          // 何回目の食事か？

  printf("=== 野菜を一日３５０ｇ食べましょう ===\n");

  for (n = 1; n <= 3; n++) {
    switch (n) {
    case 1: printf("朝ごはん"); break;
    case 2: printf("昼ごはん"); break;
    case 3: printf("夜ごはん"); break;
    }
    printf("では、何ｇ食べましたか？\n");

    // キーボードから入力された食べた野菜の量を取得します。
    scanf("%d", &vegetable);
    while (getchar() != '\n') {
      ; // 何もせず読み飛ばす
    }

    // 合計を取る
    // total += vegitable; と自己代入演算子を使って書くこともできます。
    total = total + vegetable;
    // 整数同士の割り算は切り捨てられるため、
    // 100を先に掛けることで、答が0や1になることを防ぎます。
    ratio = 100 * total / goal;
    // 書式指定子にも % を使うため、
    // printfの中で、% を表示するためには、%% を記述します。
    printf("達成率は %d %%  です\n", ratio);
    if (n <= 2 && total < goal) {
      printf("残り %d ｇの野菜を食べましょう\n\n", goal - total);
    }  else {
      printf("\n");
      break;
    }
  }

  // 結果発表
  printf ("今日は %d ｇの野菜を摂りました。\n", total);
  if (total >= goal) {
    printf("健康な食生活です(*^_^*)\n");
  } else {
    printf("もう少し野菜を食べましょう(*^_^*)\n");
  }
}

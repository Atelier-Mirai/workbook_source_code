// 自作した乱数を返す関数です。
// ヘッダーファイルとして、
// 乱数が欲しいプログラム中に読み込んで使います。

// 機能：0〜max未満の乱数を返す
// 引数：int max 乱数の最大値
// 戻値：0〜max未満の乱数
int random_number(int max) {
  srand(time(NULL));
  return (rand() % max);
}

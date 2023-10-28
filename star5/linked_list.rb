##==============================================================================
# 連結リスト
# https://ja.wikipedia.org/wiki/連結リスト
#
# マージソート
# https://ja.wikipedia.org/wiki/マージソート
# https://programming-place.net/ppp/contents/algorithm/sort/007.html
#==============================================================================

# 連結リストクラスを読み込む
require "./linked_list_class.rb"

# 線形リスト作成
list = List.new

loop do
  printf "\n何をしますか？ 0.終了、1.追加、2.削除、3.表示\n"
  answer = gets.chomp

  case answer
  when "0"
    # プログラム終了
    exit 0
  when "1"
    printf "追加する値を入力して下さい> "
    number = gets.chomp.to_i
    if list.insert_node(number) == List::SUCCESS
      puts "追加しました"
    else
      puts "追加用メモリが確保出来ませんでした"
    end
  when "2"
    printf "削除する値を入力して下さい> "
    number = gets.chomp.to_i
    if list.remove_node(number) == List::SUCCESS
      puts "削除しました"
    else
      puts "その値を持つノードは見つかりませんでした"
    end
  when "3"
    if list.show == List::NOT_FOUND
      puts "まだ何もありません"
    end
  else
    puts "正しい選択肢を入力して下さい"
  end
end

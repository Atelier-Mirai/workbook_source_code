#==============================================================================
# 連結リスト
# https://ja.wikipedia.org/wiki/連結リスト
#
# マージソート
# https://ja.wikipedia.org/wiki/マージソート
# https://programming-place.net/ppp/contents/algorithm/sort/007.html
#==============================================================================

require "debug"

# 連結リストクラスを読み込む
require "./linked_list_class.rb"

# Listクラスを拡張し、マージソートを実装する
module MergeSort
  refine List do
    # コードが書き易いよう、ノードのアドレスを返すメソッドを定義
    def addr(node)
      self.memory.key(node)
    end

    # コードが書き易いよう、アドレスにあるノードを返すメソッドを定義
    def node(addr)
      self.memory[addr]
    end

    # コードが書き易いよう、ノードに続く後継ノードを返すメソッドを定義
    def succ(node)
      self.memory[node.next]
    end

    # コードが書き易いよう、リストA(自分自身)にノードを連結するメソッドを定義
    def concat(address, other_node)
      # List.newの直後なら、受け取ったノードをそのまま追加して終了
      if self.head.nil?
        self.head = address
        self.memory.store(address, other_node)
        return
      end

      # リスト最後のノードまで進む
      node = self.node(self.head)
      until self.succ(node).nil?
        node = self.succ(node)
      end
      # リスト末尾に連結
      node.next       = address
      self.memory.store(address, other_node)
    end

    # 二つのリストを併合し、併合済のリストwを返すクラスメソッドを定義
    def List.merge(list_a, list_b)
      node_a = list_a.node(list_a.head)
      node_b = list_b.node(list_b.head)
      list_w = List.new

      loop do
        # 大小関係を比較する
        if node_a.value <= node_b.value
          # 値の小さいノードを追加する
          list_w.concat(list_a.addr(node_a), node_a)
          # 次のノードへ進む
          node_a = list_a.succ(node_a)
          if node_a.nil?
            # リストAが尽きたので、リストBの残りを繋ぐ
            until node_b.nil?
              list_w.concat(list_b.addr(node_b), node_b)
              node_b = list_b.succ(node_b)
            end
            # 連結したリストを返す
            return list_w
          end
        else
          # 値の小さいノードを追加する
          list_w.concat(list_b.addr(node_b), node_b)
          # 次のノードへ進む
          node_b = list_b.succ(node_b)
          # debugger
          if node_b.nil?
            # リストBが尽きたので、リストAの残りを繋ぐ
            until node_a.nil?
              list_w.concat(list_a.addr(node_a), node_a)
              node_a = list_a.succ(node_a)
            end
            # 連結したリストを返す
            return list_w
          end
        end
      end
    end

    # リストを二分割し、再帰的にマージする
    def mergesort
      # 長さ0, 若しくは 長さ1のリストなら自分自身を返す
      if self.head.nil? || self.succ(self.node(self.head)).nil?
        return self
      end

      # 長さ2以上なら、前半と後半のリストに分割するため、リストの中心を探す。
      # node_a の 二倍の速度でnode_bは進むため、
      # node_b がリストの末端に達した時、node_a はリストの中央に居る。
      node_a = self.node(self.head)
      node_b = self.succ(node_a)
      until node_b.nil? || self.succ(node_b).nil?
        node_a = self.succ(node_a)
        node_b = self.succ(node_b)
        unless node_b.nil?
          node_b = self.succ(node_b)
        end
      end

      # node_w 以降が後半部分のリストとなる
      node_w = self.succ(node_a)
      # node_a までが前半部分のリストとなる
      node_a.next = nil

      # 前半のリスト
      first_half = List.new
      node_a     = self.node(self.head)
      until node_a.nil?
        first_half.concat(self.addr(node_a), node_a)
        node_a = self.succ(node_a)
      end

      # 後半のリスト
      second_half = List.new
      until node_w.nil?
        second_half.concat(self.addr(node_w), node_w)
        node_w = self.succ(node_w)
      end

      # 前半と後半のリストを再帰的にマージする
      List.merge(first_half.mergesort, second_half.mergesort)
    end
  end
end
using MergeSort

# 線形リスト作成
list = List.new

# 初期値投入
list.insert_node 3
list.insert_node 2
list.insert_node 1
list.insert_node 4
list.insert_node 8
list.insert_node 7
list.insert_node 5
list.insert_node 6
list.insert_node 9

puts "--- 並び替え前 ---"
pp list
list.show
# #<List:0x0000000104e042a0
#  @head=100,
#  @memory=
#   {100=>#<struct List::Node next=120, value=3>,
#    120=>#<struct List::Node next=140, value=2>,
#    140=>#<struct List::Node next=160, value=1>,
#    160=>#<struct List::Node next=180, value=4>,
#    180=>#<struct List::Node next=200, value=8>,
#    200=>#<struct List::Node next=220, value=7>,
#    220=>#<struct List::Node next=240, value=5>,
#    240=>#<struct List::Node next=260, value=6>,
#    260=>#<struct List::Node next=nil, value=9>}>
# 3 2 1 4 8 7 5 6 9

# マージソート実行
list = list.mergesort

puts "--- 並び替え後 ---"
pp list
list.show
# #<List:0x0000000104c3f398
#  @head=140,
#  @memory=
#   {140=>#<struct List::Node next=120, value=1>,
#    120=>#<struct List::Node next=100, value=2>,
#    100=>#<struct List::Node next=160, value=3>,
#    160=>#<struct List::Node next=220, value=4>,
#    220=>#<struct List::Node next=240, value=5>,
#    240=>#<struct List::Node next=200, value=6>,
#    200=>#<struct List::Node next=180, value=7>,
#    180=>#<struct List::Node next=260, value=8>,
#    260=>#<struct List::Node next=nil, value=9>}>
# 1 2 3 4 5 6 7 8 9

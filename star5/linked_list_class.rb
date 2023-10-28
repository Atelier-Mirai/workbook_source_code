#==============================================================================
# 単方向連結リストの実装のために、
# 定数、構造体、及び、挿入/削除/表示メソッドの定義
#==============================================================================

class List
  # 定数定義
  NOT_FOUND = -1
  SUCCESS   = 1
  FAILURE   = 0

  # リスト用構造体定義
  Node = Struct.new(:next, :value)

  # アクセッサ宣言
  attr_accessor :head, :memory

  # 初期化
  def initialize
    # 先頭要素を指すポインタ（先頭要素のアドレスを格納している）
    @head   = nil
    # C ではポインタを使い、直接メモリアドレスを参照できるが、
    # Ruby でも雰囲気を感じられるよう、memory という名前のハッシュを用意する。
    # これに、各ノード要素を格納し、連結リストを実現する。
    @memory = {}
  end

  # ノードの挿入
  def insert_node(number)
    # 挿入したいノードを新規作成する
    new_node = Node.new(next: nil, value: number)

    # 空のリストであれば、そのまま追加して完了
    if self.head.nil?
      # 要素のアドレスを取得している雰囲気
      address = new_node.object_id
      # メモリの特定のアドレスに要素が書き込まれている雰囲気
      self.memory.store(address, new_node)
      # 先頭要素を指すポインタを、
      # 新規追加した要素のアドレスを指すように更新する
      self.head = address
      # 追加に成功した旨を返す
      return SUCCESS
    end

    # コレクションからリスト先頭のノード（要素）を取得する
    # (= 先頭から順にたどってきた、現在走査中のノード)
    current_node = self.memory[self.head]

    # 先頭ノードから順に末尾のノードまで走査
    loop do
      if current_node.next.nil?
        # 最後のノードを発見できたので、
        # このノードのnextとして、
        # 挿入したい新ノードのアドレスをセットする
        # これで、追加完了
        address        = new_node.object_id
        self.memory.store(address, new_node)
        current_node.next = address
        # 追加に成功した旨を返す
        return SUCCESS
      else
        # その次のノードをコレクションから取得する
        current_node = self.memory[current_node.next]
      end
    end
  end

  # ノードの削除
  def remove_node(number)
    # 空のリストであれば、何もせず、そのまま終了
    if self.head.nil?
      return NOT_FOUND
    end

    # コレクションからリスト先頭のノード（要素）を取得する
    # (= 先頭から順にたどってきた、現在走査中のノード)
    current_node = self.memory[self.head]
    # 直前のノード
    prev_node    = nil
    # その次のノード
    next_node    = self.memory[current_node.next]

    # 先頭ノードから順に、末尾のノードまで走査
    loop do
      # その値があれば、削除ノードの前のノードにつなげる
      if current_node.value == number
        # 現在ノードが先頭ノードであったなら
        if prev_node.nil?
          # 次のアドレスを一旦保持
          address = current_node.next
          # 当該ノードを削除
          memory.delete(self.head)
          # ヘッドを更新
          self.head = address
          return SUCCESS
        end

        # 現在ノードが末尾ノードであったなら
        if current_node.next.nil?
          # memoryから現在ノードを削除し、
          # 直前ノードの次を指し示さないようにして、削除完了
          address = prev_node.next
          memory.delete(address)
          prev_node.next = nil
          return SUCCESS
        end

        # 現在ノードが中間ノードであったなら
        if !(current_node.next.nil?)
          # memoryから現在ノードを削除し、
          # 直前ノードの次を指し示さないようにして、削除完了
          address = prev_node.next
          self.memory.delete(address)
          prev_node.next = current_node.next
          return SUCCESS
        end
      end

      # 現在ノードには、削除対象の値はなかったので、次のノードを調べたい
      # 次のノードがあれば、更新
      if !(current_node.next.nil?)
        prev_node = current_node
        current_node = self.memory[current_node.next]
      else
        # このノードが最後のノードであったようだ
        # 値が見つからなかったので、その旨返す
        return NOT_FOUND
      end
    end
  end

  # リストの表示
  def show
    # 空のリストであれば、何もせず、そのまま終了
    if self.head.nil?
      return NOT_FOUND
    end

    # コレクションからリスト先頭のノード（要素）を取得する
    # (= 先頭から順にたどってきた、現在走査中のノード)
    current_node = self.memory[head]
    # 先頭ノードから順に、末尾のノードまで走査
    loop do
      printf "%d ", current_node.value

      # 次のノードがあるか？
      if !(current_node.next.nil?)
        # あれば、その次のノードに更新
        current_node = self.memory[current_node.next]
      else
        # なければ、すべて表示し終わったので、終了。
        printf "\n"
        return SUCCESS
      end
    end
  end
end

# # 動作確認用
# list = List.new
# list.insert_node 10
# list.insert_node 20
# list.insert_node 30
# p list
# #=> <List:0x00000001000a3308 @head=60, @memory={60=>#<struct List::Node next=80, value=10>, 80=>#<struct List::Node next=100, value=20>, 100=>#<struct List::Node next=nil, value=30>}>
# # メモリの60番地に最初のノードが、80番地に次のノードが、100番地に最後のノードが追加されている（ように見える）
# # ノード内のnextを辿ることで、次のノードを参照でき、連結リストを実現できている。
#
# list.remove_node 20
# p list
# #=> <List:0x00000001000a3308 @head=60, @memory={60=>#<struct List::Node next=100, value=10>, 100=>#<struct List::Node next=nil, value=30>}>
# # 値20を持つノードが削除されていることを確認できる。
# list.remove_node 50
# p list
# list.remove_node 30
# p list
# list.remove_node 10
# p list
# #=> <List:0x00000001045d2668 @head=nil, @memory={}>
# # 全ノードが削除されていることが確認できる

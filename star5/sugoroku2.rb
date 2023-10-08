#==============================================================================
# 双六ゲームを創ってみましょう。
# 止まった升目に「３つ進む」や、「振り出しに戻る」も創ってみましょう。
# どこまで進んだか分かる表示機能や、
# オープニング・エンディングもあると楽しいですね。
#
# Ruby は オブジェクト指向プログラミング言語(OOP)です。
# せっかくなので、双六(Sugoroku)クラスや競技者(Competitor)クラスを作成して、
# 書き直してみます。
#
# また、
# 　　クラスメソッド(特異メソッド)
# 　　組み込みクラスの拡張(refineメソッド)
# 　　値オブジェクト(Dataクラス)
# 　　大域脱出(throw catchメソッド)
# 　　メタプログラミング(sendメソッド)
# についても、ご紹介します。
#==============================================================================

# Ruby では、標準で用意されているクラスに対しても、
# 自身で機能を追加することができます。
# 事前準備として、
# String クラスを拡張し、 to_event メソッドを定義します。
# "2マス進む" という文字列に対し、to_event メソッドを呼び出すと、
# times(回数)とverb(動作)がわかるようにします。
# times(回数)の取得
# "2マス進む".to_event.times # => 2
# verb(動作) の取得
# "2マス進む".to_event.verb # => :ahead
# これにより、前作で、「2マス進む」の意味で準備した "2A" という文字列を
# 不要にすることができます。
module StringClassRefine

  # Dataクラスは 「値オブジェクト」の定義に利用できるクラスです。
  # Dataクラスのサブクラスとして、Eventクラスを定義します。
  # Eventクラスは、times(回数)とverb(動作)という
  # 二つの読み取り専用の属性を持ちます。
  Event = Data.define(:times, :verb)

  # refine メソッドを用いると、機能追加できます。
  refine String do
    def to_event
      # \d は数字を意味する正規表現です。
      # 文字列中の数字部分に該当(match)した部分をtimesに代入します。
      times = self.match(/(\d)/).to_a[1].to_i
      verb  = if self.include? "スタート"
                :start
              elsif self.include? "ゴール"
                :goal
              elsif self.include? "進"
                :ahead
              elsif self.include? "戻"
                :back
              elsif self.include? "休"
                :rest
              else
                :no_event
              end
      # Eventクラスのインスタンスを作成します。
      # "2マス進む".to_event
      # => #<data Event::Event times=2, verb=:ahead>
      # のように、文字列"2マス進む"がEventクラスに変換されます。
      # ここから、times(回数) を取得するには、次のように書きます。
      # "2マス進む".to_event.times
      # => 2
      # verb(動作) を取得するには、次のように書きます。
      # "2マス進む".to_event.verb
      # => :ahead
      # 人から見ると、"2マス進む" の意味は明白ですが、
      # コンピュータにとっては、単なる文字列に過ぎません。
      # Eventクラスとして、times(回数)とverb(動作) として意味を抽出しましたので、
      # 前作で、「2マス進む」の意味で準備した "2A" という文字列も
      # 不要にできました。
      Event.new(times: times, verb: verb)
    end
  end
end

# StringClassRefine モジュールで、refineメソッドを使って、機能追加しました。
# これを使用するには、using メソッドを使います。
# これにより、標準のStringクラスには用意されていない to_eventメソッドを
# 使うことができるようになります。
using StringClassRefine


#==============================================================================
# 双六クラス
#==============================================================================
class Sugoroku
  # 双六のマップ配置
  # 先頭に $ をつけるとグローバル変数になります。
  # 先頭に @@ をつけると、クラス変数になります。
  # クラス内のどこからでもアクセスすることができます。
  @@map = [ "スタート",
            "",
            "",
            "",
            "2マス進む",
            "3マス戻る",
            "",
            "スタートに戻る",
            "2マス進む",
            "1回休み",
            "3マス戻る",
            "",
            "2マス進む",
            "",
            "スタートに戻る",
            "3マス戻る",
            "2マス進む",
            "",
            "2回休み",
            "",
            "3マス戻る",
            "ゴール"]

  # 定数
  GOAL_POSITION = @@map.length - 1

  # 双六競技者の配列
  # 後ほど、競技者を登録します。
  @@competitors = []

  #------------------------------------------------------------------------------
  # クラスメソッドの定義
  # 通常のメソッドは、クラスから生成されるインスタンスに属しますが、
  # クラス自身に属する クラスメソッドを作ることができます。
  # （双六へ参加する競技者は複数作成する必要がありますが）
  # 双六の地図などは、特にインスタンスを作成して地図を複数作る必要はないので、
  # クラスメソッドにします。
  #------------------------------------------------------------------------------
  class << self

    # 双六の地図
    #------------------------------------------------------------------------------
    def map
      @@map
    end


    # 開始画面描画
    #------------------------------------------------------------------------------
    def draw_opening
      # Ruby では ; は通常用いませんが、
      # 一行に複数文を記述する際には ; を使うことができます。
      # sleep 1 は一秒間、時の経過を待ちます。
      puts "The Japanese Traditional Game                            "; sleep 1;
      puts "                                                         "; sleep 1;
      puts " ####  #     #  ####   ####  #####   ####  #    # #     #"; sleep 1;
      puts "#      #     # #    # #    # #    # #    # #   #  #     #"; sleep 1;
      puts "#      #     # #      #    # #    # #    # #  #   #     #"; sleep 1;
      puts " ####  #     # #  ### #    # #####  #    # ###    #     #"; sleep 1;
      puts "     # #     # #    # #    # #  #   #    # #  #   #     #"; sleep 1;
      puts "     # ##   ##  #   # #    # #   #  #    # #   #  ##   ##"; sleep 1;
      puts "#####   #####    ###   ####  #    #  ####  #    #  ##### "; sleep 1;
      puts ""; sleep 1;
    end

    # 終了画面描画
    #------------------------------------------------------------------------------
    def draw_ending
      puts "The Japanese Traditional Game                            "; sleep 1;
      puts "                                                         "; sleep 1;
      puts "               Ｓ Ｕ Ｇ Ｏ Ｒ Ｏ Ｋ Ｕ                   "; sleep 1;
      puts "                                                         "; sleep 1;
      puts "                                                  Fin.   "; sleep 1;
    end

    # 双六への競技者登録
    #------------------------------------------------------------------------------
    def entry
      loop do
        printf "競技者名を入力してください(登録完了:f) "
        name = gets.chomp
        if name == "f"
          if @@competitors.size >= 2
            break
          else
            puts "競技者を二人以上登録してください"
          end
        else
          @@competitors << Competitor.new(name)
        end
      end
    end

    # 双六描画
    #------------------------------------------------------------------------------
    def draw_map
      puts ""
      puts " ST  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 GL"
      puts "+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+"

      # 競技者を表示
      @@competitors.each do |competitor|
        @@map.each_with_index do |_cell, index|
          printf " "
          if competitor.position == index
            printf competitor.initial

          else
            printf "  "
          end
        end
        printf "|\n"
      end
      puts "+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+"

      # 双六のイベントを、縦書きで表示
      # ["スタート",
      #  "",
      #  "",
      #  "2マス進む",
      #  "3マス戻る"]
      # =>
      # [ "ス|  |  |  |２|３|  |ス|２|１|３|  |２|  |ス|３|２|  |２|  |３|ゴ",
      #   "タ|  |  |  |マ|マ|  |タ|マ|回|マ|  |マ|  |タ|マ|マ|  |回|  |マ|ー",
      #   "ー|  |  |  |ス|ス|  |ー|ス|休|ス|  |ス|  |ー|ス|ス|  |休|  |ス|ル",
      #   "ト|  |  |  |進|戻|  |ト|進|み|戻|  |進|  |ト|戻|進|  |み|  |戻|  ",
      #   "  |  |  |  |む|る|  |に|む|  |る|  |む|  |に|る|む|  |  |  |る|  ",
      #   "  |  |  |  |  |  |  |戻|  |  |  |  |  |  |戻|  |  |  |  |  |  |  ",
      #   "  |  |  |  |  |  |  |る|  |  |  |  |  |  |る|  |  |  |  |  |  |  "]
      work = []
      m = 0; @@map.each { |cell| m = [m, cell.length].max }
      @@map.each do |cell|
        c = cell.tr("0-9", "０-９")
        s = c.split(//)
        (m - s.size).times { s << "  " }
        work << s
      end
      work = work.transpose
      result = []
      work.map { |line| result << " " + line.join("|") }
      result.each { |r| puts r }
    end

    # 双六実行
    #------------------------------------------------------------------------------
    def run
      # 開始画面描画
      Sugoroku.draw_opening

      # 何かキーを押すと開始
      message_and_wait "Press Enter to Entry"

      # 競技者登録
      Sugoroku.entry

      # 双六で遊ぶ
      Sugoroku.play

      # エンディングのご案内
      message_and_wait "Press Enter to Ending"

      # 終了画面描画
      Sugoroku.draw_opening
    end

    # 双六で遊ぶ
    #------------------------------------------------------------------------------
    def play
      # 双六の地図を表示する
      Sugoroku.draw_map

      catch(:exit) do
        loop do
          @@competitors.each do |competitor|
            message_and_wait "#{competitor.name}の番 Press Enter"

            competitor.dice_and_walk
            Sugoroku.draw_map

            if competitor.goal?
              competitor.goal(0)
              # 大域脱出
              # each メソッドを抜けるだけでしたら、break を用いれば良いですが、
              # loop を抜けることができません。
              # loop も抜けるためには、throw catch を用います。
              # catch(:exit) で始まるブロックの終わりに飛びます。
              throw :exit
            end
          end
        end
      end

      # catch(:exit) で始まるブロックを抜けると、ここに来ます。
      puts "\n競技者が上がったので 双六を終了します\n"
    end

    # メッセージを表示し、キー入力されるまで待機
    #------------------------------------------------------------------------------
    def message_and_wait(message)
      # メッセージの表示
      puts message
      # キー入力を待つ
      gets
    end
  end

  #==============================================================================
  # 競技者クラス
  # 双六クラスの中に、双六で遊ぶ競技者のためのクラスを定義します。
  # 名前などの属性と、個々の競技者(のインスタンス)用の各種メソッドを提供します。
  #==============================================================================
  class Competitor
    attr_accessor :name, :initial, :position, :number_of_rest

    # 初期化
    #------------------------------------------------------------------------------
    def initialize(name)
      @name      = name.upcase
      @initial   = @name[0]
      @initial << " " if @initial.match?(/[ -~]/) # 半角文字なら
      @position       = 0
      @number_of_rest = 0
    end

    # 進む
    #------------------------------------------------------------------------------
    def ahead(times)
      self.position += times
      if position > Sugoroku::GOAL_POSITION
        self.position = Sugoroku::GOAL_POSITION
      end

      puts "#{self.initial}> やった〜 #{times} マス 進んだ！"
    end

    # ゴールに進む
    #------------------------------------------------------------------------------
    def goal(times)
      self.position = Sugoroku::GOAL_POSITION

      puts "#{self.initial}> やった〜 ゴールに 進んだ！"
    end

    # 戻る
    #------------------------------------------------------------------------------
    def back(times)
      self.position -= times
      if self.position < 0
        self.position = 0
      end

      puts "#{self.initial}> わ〜ん #{times} マス 戻ったよ"
    end

    # スタートに戻る
    #------------------------------------------------------------------------------
    def start(times)
      self.position = 0

      puts "#{self.initial}> わ〜ん スタートに 戻ったよ"
    end

    # 休み
    #------------------------------------------------------------------------------
    def rest(times)
      self.number_of_rest = times

      puts "#{self.initial}> わ〜ん #{times} 回 休みだよ"
    end

    # イベント無し
    #------------------------------------------------------------------------------
    def no_event(times)
    end

    # 双六を上がったか、判定関数
    #------------------------------------------------------------------------------
    def goal?
      return true if self.position == Sugoroku::GOAL_POSITION
      return false
    end

    # サイコロを振って進む
    #------------------------------------------------------------------------------
    def dice_and_walk
      if self.number_of_rest > 0
        puts "#{self.initial}> #{self.number_of_rest} 回休みなので進めない・・・"
        self.number_of_rest -= 1
        return
      end

      # サイコロを振る
      dice = rand(1..6)

      # メッセージ表示
      self.ahead(dice)

      # イベント発生?
      event = Sugoroku.map[self.position].to_event
      # Sugoroku.map[self.position] は、
      # 自身の止まったマス目に書かれている文字列になります。
      # 例) 2マス進む
      # これに、to_event メソッドを呼び出すことで、
      # event = "2マス進む".to_event
      # => #<data StringClassRefine::Event times=2, verb=:ahead>
      # となります。
      # event.verb で :ahead を、event.times で 2 を取得できます。
      # sendメソッドを使うことで、自身のメソッドを呼び出すことができるので、
      # self.send(event.verb, event.times) と書いたら、
      # self.ahead(2) と同じことになります。
      # 双六のそれぞれのマス目には様々なイベントが設定されています。
      # 通常ですとイベントの種類に応じて、場合分けが必要ですが、
      # Eventクラスとsendメソッドを使うことで、一行で書くことができます。
      #   (コード自身をプログラムすることを、「メタプログラミング」と言います。
      #    少し発展的な内容とはなりますが、興味ある方は学んでみてください。)
      self.send(event.verb, event.times)
    end
  end
end

# 双六の実行
Sugoroku.run

module GoodClassMethodRefine
  refine String.singleton_class do
    def hoge
      p "hoge"
    end
  end

  refine String do
    def to_event
      p "event"
    end
  end
end

using GoodClassMethodRefine

String.hoge # ok
"aiueo".to_event

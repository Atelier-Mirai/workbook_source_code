module StringClassRefine
  Event = Data.define(:times, :verb)
  refine String do
    def to_event
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
              end
      Event.new(times: times, verb: verb)
    end
  end
end

using StringClassRefine

p "3枡戻る".to_event
p "3枡戻る".to_event.times
p "3枡戻る".to_event.verb

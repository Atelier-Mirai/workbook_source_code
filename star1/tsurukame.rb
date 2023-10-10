# 一般的には、鶴の数をt, 亀の数をkとすると、
#  t +  k =  8
# 2t + 4k = 26
# という連立一次方程式になります。
# これを解くためのアルゴリズムとして、
# ガウス法などがあります。
# ここでは、単純に力づくで解くこととします。

(0..8).each do |tsuru|
  kame = 8 - tsuru
  if tsuru * 2 + kame * 4 == 26
    break
  end
end

puts "鶴は %d 羽、亀は %d 匹います。", tsuru, kame

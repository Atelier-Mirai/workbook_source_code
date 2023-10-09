# 大きな数が読みやすいように
# 適宜「_(アンダースコア)」を入れることが出来ます。
time    = 1_2345_6789
years   = time / 3153_6000 # 3153_6000秒で割った商が時間です。
time    = time % 3153_6000 # 3153_6000秒で割った余りが残り時間です。
days    = time / 86400     # 86400秒で割った商が時間です。
time    = time % 86400     # 86400秒で割った余りが残り時間です。
hours   = time / 3600      # 3600秒で割った商が時間です。
time    = time % 3600      # 3600秒で割った余りが残り時間です。
minutes = time / 60        # 60秒で割った商が分です。
seconds = time % 60        # 60秒で割った余りが残り時間です。
printf "%d 年 %d 日 %d 時間 %d 分 %d 秒 です。\n",
        years, days, hours, minutes, seconds

# Ruby には、商と余りを同時に求める演算 divmod が用意されています。
# これを用いると次のように書けます。
time             = 1_2345_6789
years, time      = time.divmod(3153_6000) # 3153_6000で割った商がdays余りがtime
days,  time      = time.divmod(86400)     # 86400秒で割った商がdays余りがtime
hours, time      = time.divmod(3600)      # 3600秒で割った商がhours余りがtime
minutes, seconds = time.divmod(60)        # 60秒で割った商がminutes余りがseconds
printf "%d 年 %d 日 %d 時間 %d 分 %d 秒 です。\n",
        years, days, hours, minutes, seconds

# 3153_6000などと大きな数が出てきました。
# 何の数字であるか分かりやすいよう、以下のように書くと良いです。
time             = 1_2345_6789
years, time      = time.divmod(365 * 24 * 60 * 60)
days,  time      = time.divmod(24 * 60 * 60)
hours, time      = time.divmod(60 * 60)
minutes, seconds = time.divmod(60)
printf "%d 年 %d 日 %d 時間 %d 分 %d 秒 です。\n",
        years, days, hours, minutes, seconds

# yearsなど上の位から順に求めてきましたが、
# seconds など下の位から順に求めると、
# 3153_6000などの大きな数が出現せず、扱い易いです。
time          = 1_2345_6789
time, seconds = time.divmod(60)
time, days    = time.divmod(60)
time, hours   = time.divmod(24)
years, days   = time.divmod(365)
printf "%d 年 %d 日 %d 時間 %d 分 %d 秒 です。\n",
        years, days, hours, minutes, seconds

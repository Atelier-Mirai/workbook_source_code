/**************************************************************************
 * BMI を算出
 **************************************************************************/

# 変数宣言
height # 身長
weight # 体重
bmi # BMI

# 入力処理
puts "身長cmを入力して下さい。"
scanf"%d", &height
while getchar != ''


puts "体重kgを入力して下さい。"
scanf"%d", &weight
while getchar != ''


# BMI算出
# int型のheightを、キャスト演算子doubleを使って、
# double型に変換しています。
# 優先順位を明確にするため、
# doubleheight を丸括弧で囲ってから、
# 100 で割っている点に着目して下さい。
bmi = weight / powdoubleheight / 100, 2

# 結果表示
puts "BMI は %4.2f です。", bmi
if bmi < 18.5 
puts "痩せすぎです。"
 elsif bmi < 25 
puts "標準です。"
 else 
puts "肥満です。"




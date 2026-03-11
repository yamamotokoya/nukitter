# db/seeds.rb

# 既存のデータを削除してから作成（重複防止）
Genre.destroy_all

# ジャンル名のリスト
genres = ["雑談", "ゲーム実況", "歌枠", "ASMR", "料理", "企画", "お絵描き", "アダルト", "野球", "競馬", "サッカー", "YouTube", "SNS", "筋トレ", "釣り", "旅行"]

genres.each do |genre_name|
  Genre.find_or_create_by!(name: genre_name)
end

puts "--- #{Genre.count} 個のジャンルを作成しました ---"
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

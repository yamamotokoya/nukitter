# app/models/streamer.rb
class Streamer < ApplicationRecord
  # autosave: true を追加
  has_one_attached :icon
  has_many :posts, dependent: :destroy, inverse_of: :streamer, autosave: true
  accepts_nested_attributes_for :posts, allow_destroy: true, reject_if: :all_blank

  # --- 五十音検索用の定数を定義 ---
  KANA_MAP = {
    "あ" => %w(あ い う え お),
    "か" => %w(か き く け こ が ぎ ぐ げ ご),
    "さ" => %w(さ し す せ そ ざ じ ず ぜ ぞ),
    "た" => %w(た ち つ て と だ ぢ づ で ど),
    "な" => %w(な に ぬ ね の),
    "は" => %w(は ひ ふ へ ほ ば び ぶ べ ぼ ぱ ぴ ぷ ぺ ぽ),
    "ま" => %w(ま み む め も),
    "や" => %w(や ゆ よ),
    "ら" => %w(ら り る れ ろ),
    "わ" => %w(わ を ん)
  }.freeze # freezeで変更不可にする

  # --- スコープ定義 ---
  scope :by_kana_row, ->(row_letter) {
    target_chars = KANA_MAP[row_letter]
    return all unless target_chars # 該当する行がない場合は全件返す

    query_string = target_chars.map { "name_kana LIKE ?" }.join(" OR ")
    query_params = target_chars.map { |char| "#{char}%" }
    
    where(query_string, *query_params)
  }
end

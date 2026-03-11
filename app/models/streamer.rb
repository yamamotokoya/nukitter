# app/models/streamer.rb
class Streamer < ApplicationRecord
  # autosave: true を追加
  has_one_attached :icon
  has_many :posts, dependent: :destroy, inverse_of: :streamer, autosave: true
  accepts_nested_attributes_for :posts, allow_destroy: true, reject_if: :all_blank
end

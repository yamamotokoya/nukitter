class Post < ApplicationRecord
    before_save :format_x_video_url
    belongs_to :streamer, optional: true
    has_many :post_genres, dependent: :destroy
    has_many :genres, through: :post_genres
    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user
    has_one_attached :thumbnail

    def liked_by?(user)
        likes.exists?(user_id: user.id)
    end

     scope :sorted_by, ->(sort_option) {
    case sort_option
    when "views"
      order(views_count: :desc)
    when "likes"
      order(likes_count: :desc)
    else
      order(created_at: :desc)
    end
  }

  private

def format_x_video_url
  return if x_video_url.blank?

  # 1. URLから「数字のID」だけを抽出
  tweet_id = x_video_url.match(%r{status/(\d+)})&.[](1)

  if tweet_id
    # 2. 変数展開のための # と、パスの /status/ を確実に含める
    # 注意： "https://twitter.com" + tweet_id でも同じ結果になります
    self.x_video_url = "https://twitter.com/x/status/" + tweet_id
  end
end


end

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user, :logged_in?

  before_action :set_sidebar_data

  layout -> { false if turbo_frame_request? }

  def sidebar
    set_sidebar_data # 既存のデータ作成メソッド
    render partial: 'shared/sidebar' # レイアウトを無視して部品だけ返す
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  # 管理者チェック用フィルタ
  def ensure_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "管理者権限が必要です"
    end
  end

  # def set_sidebar_genres
  #   # 1. 投稿(posts)が存在するジャンルだけに絞り
  #   # 2. 投稿数(posts_count)をカウントし
  #   # 3. 投稿が多い順に並べる
  #   @sidebar_genres = Genre.joins(:posts)
  #                          .group(:id)
  #                          .select("genres.*, COUNT(posts.id) AS posts_count")
  #                          .order("posts_count DESC")

  #   if logged_in?
  #     @sidebar_likes = current_user.liked_posts.includes(:streamer).order("likes.created_at DESC").limit(5)
  #   end
  # end

  # app/controllers/application_controller.rb
def set_sidebar_data
  # 1. ジャンル一覧
  @sidebar_genres = Genre.joins(:posts).group(:id).select("genres.*, COUNT(posts.id) AS posts_count").order("posts_count DESC")
  
  # 2. ログイン中の「いいね」または「履歴」
  if logged_in?
    @sidebar_likes = current_user.liked_posts.includes(:streamer).order("likes.created_at DESC").limit(5)
    
    if @sidebar_likes.blank? && session[:view_history].present?
      history_ids = session[:view_history].take(5)
      @sidebar_histories = Post.where(id: history_ids).includes(:streamer).index_by(&:id).slice(*history_ids).values
    end
  end

  # 3. 配信者ランキング (古い @sidebar_recommended_streamers をこれに集約)
  base_query = Streamer.joins(:posts).group(:id)

  @sidebar_ranked_streamers = case params[:rank]
  when "likes" # 総いいね数順
    base_query.select("streamers.*, SUM(posts.likes_count) AS total_likes").order("total_likes DESC")
  when "views" # 総視聴回数順
    base_query.select("streamers.*, SUM(posts.views_count) AS total_views").order("total_views DESC")
  else # 投稿数順（デフォルト）
    base_query.select("streamers.*, COUNT(posts.id) AS posts_count").order("posts_count DESC")
  end.limit(5)
end

end

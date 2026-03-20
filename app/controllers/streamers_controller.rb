class StreamersController < ApplicationController
    before_action :ensure_admin!, except: :show
    before_action :set_streamer, only: [:show, :edit, :update, :destroy]
    before_action :set_columns, only: [:new, :edit]
    before_action :set_sidebar_data, only: [:index, :show, :new, :edit]

    def index
        if params[:query].present?            
            @search_word = params[:query]
    
            streamer_ids = Streamer.joins(:posts)
                                .where("posts.content LIKE ? OR streamers.name LIKE ?", "%#{@search_word}%", "%#{@search_word}%")
                                .pluck(:id).uniq

            @streamers = Streamer.where(id: streamer_ids)
                                .includes(:posts) # ビューで投稿を表示するために必要
                                .order(created_at: :desc)
        else
            @streamers = Streamer.left_joins(:posts)
                          .group(:id)
                          .includes(:posts)
                          .order("MAX(posts.created_at) DESC NULLS LAST")
        end
    end

    def show
        # @posts = @streamer.posts.includes(:genres).where.not(id: nil).order(created_at: :desc)
        @posts = @streamer.posts.includes(:genres).sorted_by(params[:sort])
        @new_post = Post.new(streamer: @streamer)
        @columns = [:content, :x_video_url, :genre_ids, :thumbnail]
    end

    def new 
        @streamer = Streamer.new
        @streamer.posts.build
        @columns = set_columns
    end

    def edit

    end

    def update
        if @streamer.update(streamer_params)
        redirect_to @streamer, notice: "配信者情報を更新しました。"
        else
        render :edit, status: :unprocessable_entity
        end
    end

    def create
        @streamer = Streamer.new(streamer_params)
        if @streamer.save 
            redirect_to root_path
        else
            p @streamer.errors.full_messages 
            @columns = set_columns
            render "new"
        end
    end

    def destroy
  @streamer = Streamer.find(params[:id])
  @streamer.destroy

  respond_to do |format|
    # 普通のアクセス（JS無効時など）は一覧に戻す
    format.html { redirect_to streamers_url, notice: "削除しました" }
    # ★魔法の発動：Turboからのアクセスなら、特定のIDの要素を消去する指示を送る
    format.turbo_stream { render turbo_stream: [
                                                turbo_stream.remove(@streamer),
                                                turbo_stream.prepend("flash-notifications", partial: "shared/flash", locals: { flash: { notice: "「#{@streamer.name}」を削除しました" } })
                                                ] }
  end
end


    private

    def streamer_params
        params.require(:streamer).permit(:name, :x_url, :icon, posts_attributes: [:id, :content, :x_video_url, :_destroy,  genre_ids: []])
    end

    def set_streamer
        @streamer = Streamer.find(params[:id])
    end

    def set_columns
        @columns = [:name, :x_url, :icon]
    end
end

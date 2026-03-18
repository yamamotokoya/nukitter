class PostsController < ApplicationController
    before_action :set_post, only: [:show, :destroy]
    before_action :ensure_admin!, only: [:new, :create, :destroy]

    def index
        @posts = Post.includes(:streamer, :genres).where.not(streamer_id: nil)

        # 検索ロジック（既存）
        if params[:query].present?
            @search_word = params[:query]
            @posts = @posts.joins(:streamer)
                        .where("posts.content LIKE ? OR streamers.name LIKE ?", "%#{@search_word}%", "%#{@search_word}%")
        end

        # 並び替えロジック（追加）
        posts_query = @posts.sorted_by(params[:sort])

        # 4. 【ここが改造ポイント】Pagyで20件ずつに分割！
        # @pagy には「今のページ番号」などの情報、@posts には「今回の20件」が入ります
        @pagy, @posts = pagy(posts_query)

        # 5. 無限スクロール用：2ページ目以降の読み込み（Turbo Stream）に対応
        respond_to do |format|
        format.html # 最初の1ページ目
        format.turbo_stream # 「もっと見る」で追加される分
        end
    end


    def new
        @post = Post.new
        @columns = set_columns
    end

    def create
        @streamer = Streamer.find(params[:streamer_id])
        @post = @streamer.posts.build(post_params)

        if @post.save
            redirect_to @streamer, notice: "投稿しました"
        else
            @columns = [:content, :x_video_url] 
            @posts = @streamer.posts.where.not(id: nil) # 一覧表示用
            
            render "streamers/show", status: :unprocessable_entity
        end
    end


    def show 
        # 再生数を1増やす（DBへ直接命令を送る）
        Post.update_counters(@post.id, views_count: 1)

        @other_posts = @post.streamer.posts.where.not(id: @post.id).order(created_at: :desc).limit(6)
        # --- 履歴の記録 ---
        # セッションから履歴を取り出す（なければ空配列）
        if @post.present?
            session[:view_history] ||= []
            session[:view_history].delete(@post.id)
            session[:view_history].unshift(@post.id)
            session[:view_history] = session[:view_history].take(10)
        end


        @other_posts = @post.streamer.posts.where.not(id: @post.id).limit(6)
    end

    def destroy
        @post.destroy
        redirect_to root_path, notice: "削除しました", status: :see_other
    end

    private 

    def post_params
        params.require(:post).permit(:content, :x_video_url, :streamer_id, genre_ids: [])
    end

    def set_columns
        [:content, :x_video_url, :genre_ids]
    end

    def set_post
        @post = Post.find(params[:id])
    end

end

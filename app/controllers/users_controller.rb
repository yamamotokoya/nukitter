class UsersController < ApplicationController
    before_action :ensure_admin!, only: :index
    before_action :set_user, only: [:show, :destroy]

    def index
        @users = User.all.order(created_at: :desc)
    end

    def show
        @liked_posts = @user.liked_posts.includes(:streamer, :genres).order("likes.created_at DESC")

        # --- 履歴取得の「鉄壁」ガード ---
        # 1. セッションが空、または配列が空なら、即座に空配列を入れて終了する
        if session[:view_history].blank?
            @history_posts = []
        else
            # 2. 履歴がある場合のみ、IDを指定して取得
            history_ids = session[:view_history].take(10)
            
            # 3. IDを配列で指定。ここでお気に入りの変数が混ざらないよう明示
            @history_posts = Post.where(id: history_ids)
                                .includes(:streamer)
                                .index_by(&:id)
                                .slice(*history_ids)
                                .values
        end
    end


   def new
        @user = User.new
        @columns = set_columns
   end
   
   def create 
    @user = User.new(user_params)
        if @user.save 
            session[:user_id] = @user.id 
            redirect_to root_path
        else
            render 'new'
        end
   end


   def destroy
    # 自分自身を削除しようとした場合はエラーにする
    if @user == current_user
      redirect_to users_path, alert: "自分自身を削除することはできません。"
    else
      @user.destroy
      redirect_to users_path, notice: "ユーザーを削除しました。", status: :see_other
    end
  end

    private 
    
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def set_columns
        [:name, :email, :password, :password_confirmation]
    end

    def set_user
        @user = User.find(params[:id])
    end
end

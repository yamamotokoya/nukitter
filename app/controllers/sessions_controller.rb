# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new # ログイン画面
  end

  # app/controllers/sessions_controller.rb
def create
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    # status: :see_other を付けることで、Turboに「別のページへ飛べ」と明示します
    redirect_to root_path, notice: "ログインしました", status: :see_other
  else
    flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません"
    render :new, status: :unprocessable_entity
  end
end


  def destroy
  session[:user_id] = nil
  # status: :see_other を追加
  redirect_to root_path, notice: "ログアウトしました", status: :see_other
end

end

class WelcomeController < ApplicationController
  layout false # ヘッダーやサイドバーを出さない専用レイアウト

  def confirm_age
  end

  def approve_age
    # 永続クッキー（20年有効）をセット
    cookies.permanent[:age_verified] = "true"
    redirect_to root_path
  end
end

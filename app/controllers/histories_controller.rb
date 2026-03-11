class HistoriesController < ApplicationController

    def destroy
        session[:view_history] = [] # nil ではなく空の配列で上書き
        redirect_to user_path(current_user), notice: "履歴を削除しました"
    end
    
end

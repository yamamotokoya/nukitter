class GenresController < ApplicationController
  def show
    @genre = Genre.find(params[:id])

    @posts = @genre.posts.includes(:streamer, :genres).order(created_at: :desc)
    # 並び替えロジック
   @posts = @genre.posts.includes(:streamer, :genres).sorted_by(params[:sort])
            

    @posts_count = @posts.count
  end
end

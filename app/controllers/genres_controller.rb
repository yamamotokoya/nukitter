class GenresController < ApplicationController
  before_action :set_columns, only: :new

  def new 
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    
    if @genre.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @genre = Genre.find(params[:id])

    @posts = @genre.posts.includes(:streamer, :genres).order(created_at: :desc)
    # 並び替えロジック
   @posts = @genre.posts.includes(:streamer, :genres).sorted_by(params[:sort])
            

    @posts_count = @posts.count
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def set_columns
    @columns = [:name]
  end
end

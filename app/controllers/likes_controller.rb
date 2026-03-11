class LikesController < ApplicationController
  before_action :set_post

  def create
    @post = Post.find(params[:post_id])
    current_user.likes.create(post: @post)

    # likes_count を 1 増やす
    Post.update_counters(@post.id, likes_count: 1)
    
    render_like_button
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post: @post)
    like.destroy

    # likes_count を 1 減らす
    Post.update_counters(@post.id, likes_count: -1)

    render_like_button
    
  end
  
  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def render_like_button
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
  end
end

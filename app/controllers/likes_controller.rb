class LikesController < ApplicationController
  def create
    post = Post.all.find(params[:post_id])
    user = current_user
    if Like.where(post_id: post.id, author_id: user.id).count.zero?
      Like.create(post: post, author: user)
      flash[:success] = 'Success: Post liked successfully'

    else
      Like.where(post_id: post.id, author_id: user.id)[0].destroy
      flash[:success] = 'Success: you disliked this post'
    end

    redirect_to user_posts_path(user_id: current_user.id)
  end
end

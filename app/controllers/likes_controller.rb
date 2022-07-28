class LikesController < ApplicationController
  def create
    puts "########################################################"
    post = Post.all.find(params[:post_id])
    user = current_user
    if Like.where(post_id: post.id, author_id: user.id).count.zero?
      flash[:success] = 'Success: Post liked successfully'
      like = Like.create(post: post, author: user)

    else
      flash[:success] = 'Success: you disliked this post'
      like = Like.where(post_id: post.id, author_id: user.id)[0].destroy
    end

    redirect_to user_posts_path(user_id: current_user.id)
  end
end
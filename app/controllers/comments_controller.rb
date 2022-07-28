class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
   comment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { comment: comment } }
    end
  end

  def create
    comment_text = params.require(:comment).permit(:text)[:text]
    post = Post.where(id: params[:post_id])[0]

    new_comment = Comment.new(post: post, author: current_user, text: comment_text)

    new_comment.save
  
    if new_comment.save
      new_comment.update_comments_counter
      flash[:success] = 'Success: Comment created successfully'
      redirect_to user_post_path(post.author_id,post)
    else
      flash.now[:error] = 'Error: Comment creation failed'
      render :show, locals: { post: post }
    end
  end
end
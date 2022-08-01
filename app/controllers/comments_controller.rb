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
      flash[:success] = 'Success: Comment created successfully'
      redirect_to user_post_path(post.author_id, post)
    else
      flash.now[:error] = 'Error: Comment creation failed'
      render :show, locals: { post: post }
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], author_id: current_user.id, post_id: params[:post_id])
    if @comment.destroy
      flash[:success] = 'Success: Comment deleted successfully'
      redirect_to user_post_path(@comment.post.author_id, @comment.post)
    else
      flash.now[:error] = 'Error: Comment deletion failed'
      render :show, locals: { post: @comment.post }
    end
  end
end

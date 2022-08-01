class Api::CommentsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authorize_request

  def index
    @post = Post.where(author_id: params[:user_id], id: params[:post_id])
    @comments = Comment.where(post: @post)
    render json: @comments, status: :ok
  end

  def create
    comment_text = params.require(:comment).permit(:text)[:text]
    post = Post.where(id: params[:post_id])[0]

    @new_comment = Comment.new(post: post, author: current_user, text: comment_text)
    @new_comment.save
    render json: @new_comment, status: :created
  end
end

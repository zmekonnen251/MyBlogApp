class Api::PostsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authorize_request

  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id)
    render json: @posts, status: :ok
  end
end

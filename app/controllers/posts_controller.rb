class PostsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @user_posts = @user.posts.all.includes(:comments)

    @current_user_id = current_user.id
  end

  def show
    @post = Post.where(author_id: params[:user_id]).where(id: params[:id])[0]
    @current_user_id = current_user.id
  end

  def new
    @post = Post.new
    render :new, locals: { post: @post }
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.author_id = current_user.id


    respond_to do |format|
      format.html do
        if @post.save
          # Success message
          flash.now[:success] = 'Post created successfully'
          redirect_to user_posts_path(current_user.id)
        else
          # Error message
          flash.now[:error] = 'Error: Post creation failed'
          render :new, locals: { post: @post }
        end
      end
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id], author_id: current_user.id)
    like = Like.find_by(post_id: @post.id)
    comment = Comment.find_by(post_id: @post.id)

    like.destroy if like.present?
    comment.destroy if comment.present?

    if @post.destroy
      # Success message
      flash.now[:success] = 'Post deleted successfully'
      redirect_to user_posts_path(current_user.id)
    else
      # Error message
      flash.now[:error] = 'Error: Post deletion failed'
      render :new, locals: { post: @post }
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

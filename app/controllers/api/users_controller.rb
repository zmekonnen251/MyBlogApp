class Api::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{name}
  def show
    render json: @user, status: :ok
  end

  # POST /users

  def create
    puts '################################################'
    if params[:email] == params[:email_confirmation] && (params[:password] == params[:password_confirmation])
      @user = User.new(user_params)
    end

    puts '################################################'
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_message }, status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    render json: { errors: @user.errors.full_message }, status: :unprocessable_entity unless @user.update(user_params)
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(:photo, :name, :email, :bio, :password, :password_confirmation)
  end
end

class UsersController < ApplicationController
  def index
    @users = User.all
    puts "current_user: #{current_user.name}"
  end

  def show
    @user = User.find(params[:id])
  end
end

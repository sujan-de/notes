class UsersController < ApplicationController
  before_action :correct_user, only: [:show]

  def show
    @user = User.find_by(id: params[:id])
  end

  private

  def correct_user
    user = User.find_by(id: params[:id])
    redirect_to(user_path(current_user)) if current_user != user
  end
end
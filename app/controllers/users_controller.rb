class UsersController < ApplicationController
  def create
    @user = User.create create_params
    render_resource @user
  end

  def update
    @user = User.find params[:id]
    @user.update update_params
    render_resource @user
  end

  def show
    @user = User.find(params[:id])
    render_resource @user
  end

  private

  def create_params
    params.permit(:email, :password, :password_confirmation)
  end

  def update_params
    params.permit(:name)
  end
end

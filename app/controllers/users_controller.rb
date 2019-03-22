class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(permitted_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def permitted_params
    params.require(:user).permit(:password)
  end
end

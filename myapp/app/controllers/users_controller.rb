class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "you have signed up successfully."
      redirect_to projects_path
    else
      render "new"
    end
  end

  def update
    @user= User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "user profile updated successfully."
      redirect_to projects_path
    else
      flash[:alert] = "user profile has not been updated."
      render "edit"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmations)
    end
end

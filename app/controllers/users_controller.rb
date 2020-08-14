class UsersController < ApplicationController

  def create
    if current_user.create(user_params)
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday)
  end

end

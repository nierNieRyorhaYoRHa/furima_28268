class UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params) # 更新出来たかを条件分岐する
      sign_in(@user)
      redirect_to root_path and return # 更新できたらrootパスへ
    else
      render :edit and return # 失敗すれば再度マイページへ
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday)
  end

end

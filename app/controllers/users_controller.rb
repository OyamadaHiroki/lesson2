class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:me, :edit, :update, :destroy]}
  before_action :forbid_login_user, {only: [:new, :create]}

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      session[:user_id] = user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to posts_path
    else
      flash[:error_messages] = user.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
    
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
          flash[:notice] = "編集が完了しました"
          redirect_to user_path
      else
          flash[:notice] = "編集が失敗しました"
          render 'users/edit'
      end
  end

  def destroy
  end

  def me
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :profile, :email, :password, :password_confirmation)
  end

end

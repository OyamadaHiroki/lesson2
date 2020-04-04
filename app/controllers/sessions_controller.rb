class SessionsController < ApplicationController
  before_action :forbid_login_user, {only: [:create]}
  before_action :authenticate_user, {only: [:destroy]}

  def create
    user = User.find_by(email: params[:sessions][:email])
    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      flash[:notice] = "ログインしました"
      redirect_to mypage_path
    else
      render "home/index"
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_path
  end

end

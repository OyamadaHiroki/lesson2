class RepriesController < ApplicationController
  before_action :authenticate_user

  def create
    repry = Repry.new(repry_params)
    repry.user_id = @current_user.id
    if repry.save
      flash[:notice] = 'コメントしました'
      redirect_to repry.post
    else
      redirect_to :back, flash: {
        repry: repry,
        error_messages: repry.errors.full_messages
    }
    end
  end
    
  def destroy
    repry = Repry.find(params[:id])
    repry.delete
    redirect_to repry.post, {notice: 'コメントが削除されました'}
  end

  private

  def repry_params
    params.require(:repry).permit(:repry, :post_id)
  end

end

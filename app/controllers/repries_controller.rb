class RepriesController < ApplicationController

  def create
    @repry = Repry.new(repry_params)
    if @repry.save
      flash[:notice] = 'リプライしました'
      redirect_to @repry.post
    else
      redirect_to :back, flash: {
        repry: @repry,
        error_messages: @repry.errors.full_messages
    }
    end
  end
    
  def destroy
    repry = set_target_repry
    repry.delete
    redirect_to repry.post, {notice: 'コメントが削除されました'}
  end

  private

  def repry_params
    params.require(:repry).permit(:post_id, :repry)
  end

  def set_target_repry
    repry = Repry.find(params[:id])
  end
end

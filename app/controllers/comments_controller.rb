class CommentsController < ApplicationController
  # before_action :comment_params

  def create
    @comment = Comment.new(text: params[:comment][:text], user_id: current_user.id, item_id: params[:item_id])
    ActionCable.server.broadcast 'comment_channel', content: @comment if @comment.save
  end

  # def comment_params
  # params.permit(comment:[:text]).merge(user_id: current_user.id, item_id: params[:item_id])
  # params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  # end
end

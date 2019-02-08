class MessagesController < ApplicationController
  def index
    @current_group = Group.find(params[:group_id])
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if !@message.save
      render :index, notice: 'メッセージを入力してください。'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :image, :image_cache, :group_id, :user_id)
  end
end

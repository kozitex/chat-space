class MessagesController < ApplicationController
  before_action :set_group

  def index
    @message = Message.new
    set_messages
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @message = Message.create(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path(@current_group), notice: 'メッセージが送信されました。' }
        format.json
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :image, :image_cache).merge(group_id: params[:group_id], user_id: current_user.id)
  end

  def set_group
    @current_group = Group.find(params[:group_id])
  end

  def set_messages
    @messages = @current_group.messages.includes(:user)
  end

end

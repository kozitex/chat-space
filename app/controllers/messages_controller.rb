class MessagesController < ApplicationController
  def index
    if params[:group_id]
      @current_group = Group.find(params[:group_id])
    end
  end
end

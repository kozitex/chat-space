class GroupsController < ApplicationController
  def index
    if params[:group_id]
      @current_group = Group.find(params[:group_id])
    end
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.create(group_params)
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました。'
    else
      render :new
    end
  end

  def edit
    set_group
  end

  def update
    set_group
    if @group.update(group_params)
      redirect_to root_path, notice: 'グループを編集しました。'
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, { user_ids: []})
  end

  def set_group
    @group = Group.find(params[:id])
    @users = @group.users.where.not(id: current_user.id)
  end

end

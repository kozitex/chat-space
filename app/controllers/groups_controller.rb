class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    Group.create(group_params)
  end

  def edit
  end

  def update
  end

  private
  def group_params
    params.require(group).permit(:name)
  end

end

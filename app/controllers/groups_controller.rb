class GroupsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    Post.create(group_params)
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

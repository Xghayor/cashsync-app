class GroupsController < ApplicationController
  load_and_authorize_resource

  def index 
    @user = current_user
   @groups = Group.all
  end

  def new
    @user = current_user
    @group = @user.groups.build
  end

  def create
    @user = current_user
    @group = @user.groups.build(group_params)
    if @group.save
      redirect_to authenticated_root_path
    else
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end

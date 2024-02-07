class GroupsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_current_user, only: [:index, :new, :create]

  def index
    @groups = @user.groups
  end

  def new
    @group = @user.groups.build
  end

  def create
    @group = @user.groups.build(group_params)
    if @group.save
      redirect_to authenticated_root_path
    else
      render :new
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end

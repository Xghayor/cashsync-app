class EntitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_and_group

  def index
    @entities = @group.entities
  end

  def new
    @entity = @group.entities.build
  end

  def create
    @entity = @group.entities.build(entity_params)
    @entity.author = current_user
    if @entity.save
      redirect_to user_group_entities_path(@user, @group)
    else
      render :new
    end
  end

  private

  def set_user_and_group
    @user = current_user
    @group = @user.groups.find(params[:group_id])
  end

  def entity_params
    params.require(:entity).permit(:name, :amount)
  end
end

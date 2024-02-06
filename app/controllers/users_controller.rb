class UsersController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    def show
        @user = current_user
    end
end

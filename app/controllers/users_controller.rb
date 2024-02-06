class UsersController < ApplicationController
    load_and_authorize_resource

    def show
        @user = current_user
    end
end

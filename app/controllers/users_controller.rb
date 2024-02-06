class UsersController < ApplicationController
    before_action :authenticate_user!
    
    def index
       @greetings =  "hello world"
    end
end

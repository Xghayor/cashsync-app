class ApplicationController < ActionController::Base
  before_action :authenticate_specific_controllers
  before_action :configure_permitted_parameters, if: :devise_controller?
   
  protected

  def authenticate_specific_controllers
    if %w[user entity group].include?(controller_name)
      authenticate_user!
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  end
end

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password,
      :password_confirmation, :remember_me, :avatar, :avatar_cache, :remove_avatar) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password,
      :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar) }
  end
end

class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  layout :layout
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_page
    params[:page]
  end

  protected

  def configure_permitted_parameters
    attributes = %i[name email password password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  private

  def layout
    if devise_controller? && devise_mapping.name == :moderator
      'admin_devise'
    else
      'application'
    end
  end

  def user_not_authorized
    flash[:notice] = 'You are not authorized to perform this action.'
    redirect_to(new_user_session_path)
  end
end

class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_moderator!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  def pundit_user
    current_moderator
  end
  
  private

  def user_not_authorized
    flash[:notice] = 'У вас нет прав совершать это действие.'
    redirect_to(admin_path)
  end
end

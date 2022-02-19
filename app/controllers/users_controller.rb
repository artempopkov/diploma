class UsersController < ApplicationController
  layout 'user_profile'
  before_action :load_models, only: %i[show likes_history]
  before_action :authenticate_user!, only: %i[show likes_history]

  def show
    authorize @user
  end

  private

  def load_models
    @user = current_user
    user_history_service = UserHistoryService.new(@user)
    @likes_amount = user_history_service.likes_amount
    @views_amount = user_history_service.views_amount
    @comments_amount = user_history_service.comments_amount
  end
end

class UsersController < ApplicationController
  layout 'user_profile'
  before_action :load_models, only: %i[show likes_history]
  before_action :authenticate_user!, only: %i[show likes_history]

  def show
    authorize @user
    
    @likes_amount = UserHistoryService.new(@user).likes_history.count
  end

  def likes_history
    authorize @user
    
    @likes_history = UserHistoryService.new(@user).likes_history.paginate(page: current_page)
  end

  private

  def load_models
    @user = current_user
  end
end

class UsersController < ApplicationController
  before_action :load_models, only: %i[show]
  before_action :authenticate_user!, only: %i[show]
  def show
    authorize @user
    
    @likes_history = UserHistoryService.new(@user).likes_history.paginate(page: current_page)
  end

  private

  def load_models
    @user = current_user
  end
end

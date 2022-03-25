class UserHistoriesController < ApplicationController
  layout 'user_profile'
  before_action :load_models, only: %i[likes comments views]
  before_action :authenticate_user!, only: %i[likes comments views]

  def show
    authorize @user
  end

  def likes
    
    @likes_history = UserHistoryService.new(@user).likes.sort_by { |e| e[1] }.reverse.paginate(page: current_page)
  end

  def comments
    @comments_history = UserHistoryService.new(@user).comments.sort_by { |e| e[1] }.reverse.paginate(page: current_page)
  end

  def views
    @views_history = UserHistoryService.new(@user).views.sort_by { |e| e[1] }.reverse.paginate(page: current_page)
  end
  
  private

  def load_models
    @user = User.find(params[:id])
    user_history_service = UserHistoryService.new(@user)
    @likes_amount = user_history_service.likes_amount
    @views_amount = user_history_service.views_amount
    @comments_amount = user_history_service.comments_amount
  end
end

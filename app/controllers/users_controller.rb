class UsersController < ApplicationController
  layout 'user_profile'
  before_action :load_models, only: %i[show]
  before_action :authenticate_user!, only: %i[show]

  def show
    authorize @user
  end

  private

  def load_models
    @user = current_user
  end
end

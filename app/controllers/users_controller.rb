class UsersController < ApplicationController
  before_action :load_models, only: %i[show]

  def show
  end

  private

  def load_models
    @user = current_user
  end
end

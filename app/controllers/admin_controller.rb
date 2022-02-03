class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_moderator!

  def pundit_user
    current_moderator
  end
end

class ApplicationController < ActionController::Base
  def current_page
    params[:page]
  end
end

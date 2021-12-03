class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_moderator!
  PER_PAGE = 10
end

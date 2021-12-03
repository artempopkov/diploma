class AdminController < ApplicationController
  before_action :authenticate_moderator!
end

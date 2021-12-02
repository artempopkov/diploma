class Admin::ModeratorsController < AdminController

  def index
    @moderators = Moderator.order(:id)
  end
end

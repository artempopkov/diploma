class Admin::ModeratorsController < AdminController

  def index
    @moderators = Moderator.order(:id)
  end

  def new
    @moderator = Moderator.new
  end

  def create
    @moderator = Moderator.new moderator_params
    if @moderator.save
      redirect_to admin_moderators_url, notice: "Creation finish successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def moderator_params
    params.require(:moderator).permit(:email, :name, :password, :password_confirmation)
  end
end

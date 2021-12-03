class Admin::ModeratorsController < AdminController
  before_action :load_models, only: %i[edit update]

  def index
    @moderators = Moderator.order(:id)
  end

  def new
    @moderator = Moderator.new
  end

  def edit
  end

  def create
    @moderator = Moderator.new moderator_params
    if @moderator.save(validate: false)
      redirect_to admin_moderators_url, notice: 'Creation finish successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @moderator.update moderator_params
      redirect_to admin_moderators_url, notice: 'Updating finish successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def load_models
    @moderator = Moderator.find params[:id]
  end

  def moderator_params
    params.require(:moderator).permit(:email, :name)
  end
end
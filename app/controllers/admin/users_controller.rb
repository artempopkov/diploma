class Admin::UsersController < AdminController
  def index
    @users = User.order(:id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save(validate: false)
      redirect_to admin_users_url, notice: 'Creation finish successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def load_models
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :name)
  end
end

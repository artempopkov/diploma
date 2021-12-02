class Admin::UsersController < AdminController
  before_action :load_models, only: %i[edit update destroy]

  def index
    @users = User.order(:id)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new user_params
    if @user.save(validate: false)
      redirect_to admin_users_url, notice: 'Creation finish successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update user_params
      redirect_to admin_users_url, notice: "Updating finish successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: "Destruction finish successfully"
  end

  private

  def load_models
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :name)
  end
end

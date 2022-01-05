module Admin
  class UsersController < AdminController
    before_action :load_models, only: %i[edit update destroy]

    def index
      @users = User.page(current_page).order(:id)
      authorize [:admin, @users]
    end

    def new
      @user = User.new
      authorize [:admin, @user]
    end

    def edit
    end

    def create
      @user = User.new user_params
      authorize [:admin, @user]
      if @user.save
        redirect_to admin_users_url, notice: 'Creation finish successfully'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      authorize [:admin, @user]
      if @user.update user_params
        redirect_to admin_users_url, notice: 'Updating finish successfully'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize [:admin, @user]
      @user.destroy
      redirect_to admin_users_url, notice: 'Destruction finish successfully'
    end

    private

    def load_models
      @user = User.find params[:id]
    end

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
  end
end

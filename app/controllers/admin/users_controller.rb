module Admin
  class UsersController < AdminController
    before_action :load_models, only: %i[edit update destroy]
    after_action :verify_authorized

    def index
      authorize [:admin, User]
      respond_to do |format|
        format.html
        format.json { render json: UsersDatatable.new(params, view_context: view_context) }
      end
    end

    def new
      @user = User.new
      authorize [:admin, @user]
    end

    def edit
      authorize [:admin, @user]
    end

    def create
      @user = User.new user_params
      authorize [:admin, @user]
      if @user.save
        redirect_to admin_users_url, notice: 'Пользователь успешно создан'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      authorize [:admin, @user]
      if @user.update user_params
        redirect_to admin_users_url, notice: 'Пользователь успешно обновлён'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize [:admin, @user]
      @user.destroy
      redirect_to admin_users_url, notice: 'Пользователь успешно удалён'
    rescue StandardError => e
      redirect_to admin_url, notice: 'Ошибка создания удаления'
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

module Admin
  class ModeratorsController < AdminController
    before_action :load_models, only: %i[edit update destroy]
    after_action :verify_authorized

    def index
      authorize [:admin, User]
      respond_to do |format|
        format.html
        format.json { render json: ModeratorsDatatable.new(params, view_context: view_context) }
      end
    end

    def new
      @moderator = Moderator.new
      authorize [:admin, @moderator]
    end

    def edit
      authorize [:admin, @moderator]
    end

    def create
      @moderator = Moderator.new moderator_params
      authorize [:admin, @moderator]
      if @moderator.save
        redirect_to admin_moderators_url, notice: 'Creation finish successfully'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      authorize [:admin, @moderator]
      if @moderator.update moderator_params
        redirect_to admin_moderators_url, notice: 'Updating finish successfully'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize [:admin, @moderator]
      @moderator.destroy
      redirect_to admin_moderators_url, notice: 'Destruction finish successfully'
    end

    private

    def load_models
      @moderator = Moderator.find params[:id]
    end

    def moderator_params
      params.require(:moderator).permit(:email, :name, :password, :password_confirmation, :role)
    end
  end
end

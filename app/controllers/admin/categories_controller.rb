module Admin
  class CategoriesController < AdminController
    before_action :load_models, only: %i[show edit update destroy]
    after_action :verify_authorized

    def index
      authorize [:admin, Category]
      respond_to do |format|
        format.html
        format.json { render json: CategoriesDatatable.new(params, view_context: view_context) }
      end
    end

    def show
    end

    def new
      @category = Category.new
      authorize [:admin, @category]
    end

    def edit
      authorize [:admin, @category]
    end

    def create
      @category = Category.new(category_params)
      authorize [:admin, @category]
      if @category.save
        redirect_to admin_categories_url, notice: 'Категория успешно создана'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      authorize [:admin, @category]
      if @category.update(category_params)
        redirect_to admin_categories_url, notice: 'Категория успешно обновлена'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize [:admin, @category]
      result = Categories::Destroy.call(category: @category)
      if result.success?
        redirect_to admin_categories_url, notice: 'Категория успешно удалена'
      else
        redirect_to admin_categories_url, alert: result.message
      end
    end

    private

    def load_models
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
  end
end

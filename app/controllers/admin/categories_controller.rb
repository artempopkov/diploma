module Admin
  class CategoriesController < AdminController
    before_action :load_models, only: %i[show edit update destroy]

    def index
      @categories = Category.page(current_page).order(:id)
      authorize [:admin, @categories]
    end

    def show
    end

    def new
      @category = Category.new
      authorize [:admin, @category]
    end

    def edit
    end

    def create
      @category = Category.new(category_params)
      authorize [:admin, @category]
      if @category.save
        redirect_to admin_categories_url, notice: 'Creation finish successfully'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      authorize [:admin, @category]
      if @category.update(category_params)
        redirect_to admin_categories_url, notice: 'Updating finish successfully'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize [:admin, @category]
      @category.destroy
      redirect_to admin_categories_url, notice: 'Destruction finish successfully'
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

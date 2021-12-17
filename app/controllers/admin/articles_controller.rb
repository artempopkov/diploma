module Admin
  class ArticlesController < AdminController
    before_action :set_models, only: %i[show edit update destroy]

    def index
      if params.key?(:cat)
        @category = Category.find(params[:cat])
        @articles = @category.articles.order(:id)
      else
        @articles = Article.includes(:category).order(:id)
      end
    end

    def show
    end

    def new
      @article = Article.new
    end

    def edit
    end

    def create
      @article = Article.new(article_params)
      if @article.save
        redirect_to [:admin, @article], notice: 'Creation finish successfully'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @article.remove_avatar! if @article.avatar.present? && article_params[:avatar].present?

      if @article.update(article_params)
        redirect_to [:admin, @article], notice: 'Updating finish successfully'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @article.destroy
      redirect_to admin_articles_url, notice: 'Destruction finish successfully'
    end

    private

    def set_models
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description, :content, :avatar, :avatar_disable, :category_id)
    end
  end
end
module Admin
  class ArticlesController < AdminController
    before_action :tag_cloud
    before_action :load_models, only: %i[show edit update destroy send_for_review]
    before_action :load_categories, only: %i[index new edit]

    def index
      @query = Article.ransack(params[:query])
      @articles = @query.result.includes(:category)
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
        redirect_to admin_article_url(@article), notice: "Creation finish successfully"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @article.update(article_params)
        redirect_to admin_article_url(@article), notice: "Update finish successfully"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @article.destroy
      redirect_to admin_articles_url, notice: "Destruction finish successfully"
    end

    def tag_cloud
      @tags = Article.tag_counts_on(:tags)
    end

    def send_for_review
      @article.active!
      redirect_to admin_article_url(@article), notice: 'Article sent for review'
    end

    private

    def load_models
      @article = Article.find(params[:id])
    end

    def load_categories
      @categories = Category.order(:id)
    end

    def article_params
      params.require(:article).permit(:title, :description, :content, :avatar, :remove_avatar, :avatar_disable, :category_id, :tag_list, :status)
    end
  end
end

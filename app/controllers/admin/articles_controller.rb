module Admin
  class ArticlesController < AdminController
    before_action :load_models, only: %i[show edit update destroy send_for_review]
    before_action :load_categories, only: %i[index new edit]
    before_action :tag_cloud
    after_action :verify_authorized

    def index
      @query = Article.ransack(params[:query])
      @articles = @query.result.includes(:category)
      authorize [:admin, @articles]
    end

    def show
      authorize [:admin, @article]
    end

    def new
      @article = Article.new
      authorize [:admin, @article]
    end

    def edit
      authorize [:admin, @article]
    end

    def create
      @article = current_moderator.articles.build(article_params)
      authorize [:admin, @article]
      if @article.save
        redirect_to admin_article_url(@article), notice: "Creation finish successfully"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @article = Article.find(params[:id])
      authorize [:admin, @article]
      if @article.update(article_params)
        redirect_to admin_article_url(@article), notice: "Update finish successfully"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize [:admin, @article]
      @article.destroy
      redirect_to admin_articles_url, notice: "Destruction finish successfully"
    end

    def tag_cloud
      @tags = Article.tag_counts_on(:tags)
    end

    def send_for_review
      authorize [:admin, @article]
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

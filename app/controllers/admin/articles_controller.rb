module Admin
  class ArticlesController < AdminController
    before_action :load_models, only: %i[show edit update destroy prepare publish remove_avatar]
    before_action :load_categories, only: %i[index new edit]
    before_action :tag_cloud
    after_action :verify_authorized

    def index
      @query = policy_scope([:admin, Article]).ransack(params[:query])
      @articles = @query.result.includes(:category)
      authorize [:admin, @articles]
    end

    def show
      @reviews = @article.reviews.includes(:moderator).page(current_page).order("id DESC")
      @review = @article.reviews.build if current_moderator.editor?
      @review_statuses = ArticleReview.statuses
      authorize [:admin, @article]

      respond_to do |format|
        format.html
        format.js
      end
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
        redirect_to admin_article_url(@article), notice: 'Create finish successfully'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @article = Article.find(params[:id])
      authorize [:admin, @article]
      if @article.update(article_params)
        redirect_to admin_article_url(@article), notice: 'Update finish successfully'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize [:admin, @article]
      @article.destroy
      redirect_to admin_articles_url, notice: 'Destroy finish successfully'
    end

    def remove_avatar
      authorize [:admin, @article]

      result = Articles::RemoveAvatar.call(article: @article)
      if result.success?
        redirect_to edit_admin_article_path(@article), notice: 'Avatar removed successfully'
      else
        redirect_to edit_admin_article_path(@article), error: result.message
      end
    end

    def prepare
      authorize [:admin, @article]

      result = Articles::Prepare.call(article: @article)
      if result.success?
        redirect_to admin_article_url(@article), notice: 'Prepare finish successfully'
      else
        redirect_to admin_articles_url, error: result.message
      end
    end

    def publish
      authorize [:admin, @article]

      result = Articles::Publish.call(article: @article)
      if result.success?
        redirect_to admin_article_url(@article), notice: 'Publish finish successfully'
      else
        redirect_to admin_articles_url, error: result.message
      end
    end

    def tag_cloud
      @tags = Article.tag_counts_on(:tags)
    end

    private

    def load_models
      @article = Article.find(params[:id])
    end

    def load_categories
      @categories = Category.order(:id)
    end

    def article_params
      params.require(:article).permit(:title, :description, :content, :avatar, :avatar_disable, :category_id, :tag_list, :status)
    end
  end
end

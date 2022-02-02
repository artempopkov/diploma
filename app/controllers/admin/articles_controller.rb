module Admin
  class ArticlesController < AdminController
    before_action :set_models, only: %i[show edit update destroy send_for_review publish]
    before_action :tag_cloud
    after_action :verify_authorized

    def index
      if params.key?(:cat)
        @category = Category.find(params[:cat])
        @articles = policy_scope [:admin, @category.articles.order(:id)]
      elsif params.key?(:tag)
        @articles = policy_scope([:admin, Article]).tagged_with(params[:tag])
      else
        @articles = policy_scope([:admin, Article]).order(:id)
      end
      authorize [:admin, @articles]
    end

    def show
      @review = @article.reviews.build if current_moderator.editor?
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
        redirect_to [:admin, @article], notice: 'Creation finish successfully'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @article = Article.find(params[:id])
      authorize [:admin, @article]
      if @article.update(article_params)
        redirect_to [:admin, @article], notice: 'Update finish successfully'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize [:admin, @article]
      @article.destroy
      redirect_to admin_articles_url, notice: 'Destruction finish successfully'
    end

    def tag_cloud
      @tags = Article.tag_counts_on(:tags)
    end

    private

    def set_models
      @article ||= Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description, :content, :avatar, :remove_avatar, :avatar_disable, :category_id, :tag_list, :status)
    end
  end
end

module Admin
  class ArticlesController < AdminController
    before_action :set_models, only: %i[show edit update destroy send_for_review]
    before_action :tag_cloud

    def index
      if params.key?(:cat)
        @category = Category.find(params[:cat])
        @articles = @category.articles.order(:id)
      elsif params.key?(:tag)
        @articles = Article.tagged_with(params[:tag])
      else
        @articles = Article.order(:id)
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

    def tag_cloud
      @tags = Article.tag_counts_on(:tags)
    end

    def send_for_review
      @article.status = 'active'
      @article.save!
      redirect_to [:admin, @article], notice: 'Article sent for review'
    end

    private

    def set_models
      @article ||= Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description, :content, :avatar, :avatar_disable, :category_id, :tag_list, :status)
    end
  end
end

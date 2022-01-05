module Admin
  class ArticlesController < AdminController
    before_action :set_models, only: %i[show edit update destroy send_for_review]
    before_action :tag_cloud
    after_action :verify_authorized

    def index
      if params.key?(:cat)
        @category = Category.find(params[:cat])
        @articles = @category.articles.order(:id)
      elsif params.key?(:tag)
        @articles = policy_scope([:admin, Article]).tagged_with(params[:tag])
      else
        @articles = policy_scope([:admin, Article]).order(:id)
      end
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

    def send_for_review
      @article.status = 'active'
      @article.save!
      redirect_to [:admin, @article], notice: 'Article sent for review'
    end

    def pundit_user
      current_moderator
    end

    private

    def permission_denied
      flash[:error] = "You don't have the proper permissions to view this page. If you think you are supposed to then please contact us at permissions@inrtracker.com"
      self.response_body = nil # This should resolve the redirect root.
      redirect_to(request.referer || root_path)
    end

    def set_models
      @article ||= Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description, :content, :avatar, :remove_avatar, :avatar_disable, :category_id, :tag_list, :status)
    end
  end
end

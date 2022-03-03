module Admin
  class ArticlesController < AdminController
    before_action :load_models, only: %i[show edit update destroy prepare publish toggle_important remove_avatar]
    before_action :load_categories, only: %i[index new edit]
    before_action :tag_cloud
    after_action :verify_authorized
    respond_to :js

    def index
      @query = policy_scope([:admin, Article]).ransack(params[:query])
      @articles = @query.result(distinct: true).includes(:category).order(id: :desc).page(current_page)
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

      @article.tag_list = article_params[:tag_list].join(' ')
      authorize [:admin, @article]
      if @article.save
        redirect_to admin_article_url(@article), notice: 'Статья успешно создана'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @article = Article.find(params[:id])
      authorize [:admin, @article]

      @article.tag_list = article_params[:tag_list].join(' ')
      if @article.update(article_params)
        redirect_to admin_article_url(@article), notice: 'Статья успешно обновлена'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize [:admin, @article]
      @article.destroy
      redirect_to admin_articles_url, notice: 'Статья успешно удалена'
    rescue StandardError => e
      redirect_to admin_moderators_url, notice: 'Ошибка удаления'
    end

    def remove_avatar
      authorize [:admin, @article]

      result = Articles::RemoveAvatar.call(article: @article)
      if result.success?
        redirect_to edit_admin_article_path(@article), notice: 'Аватар успешно удалён'
      else
        redirect_to edit_admin_article_path(@article), alert: result.message
      end
    end

    def prepare
      authorize [:admin, @article]

      result = Articles::Prepare.call(article: @article)
      if result.success?
        redirect_to admin_article_url(@article), notice: 'Статья подготовленная для проверки'
      else
        redirect_to admin_articles_url, alert: result.message
      end
    end

    def publish
      authorize [:admin, @article]

      result = Articles::Publish.call(article: @article)
      if result.success?
        redirect_to admin_article_url(@article), notice: 'Статья опубликована'
      else
        redirect_to admin_articles_url, alert: result.message
      end
    end

    def toggle_important
      authorize [:admin, @article]
      result = Articles::ToggleImportant.call(article: @article, important: params[:important])

      if result.success?
        respond_to :js
      else
        redirect_to admin_article_url(@article), alert: result.message
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
      params.require(:article).permit(:title, :description, :content, :avatar, :avatar_disable, :category_id, {:tag_list => []}, :status, :important)
    end
  end
end

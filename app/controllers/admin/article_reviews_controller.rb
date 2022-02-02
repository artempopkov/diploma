module Admin
  class ArticleReviewsController < AdminController
    before_action :load_models, only: %i[send_article_for_review publish_article]

    def new
      @review = Review.new
    end

    def create
      @review = Review.new(review_params)
      if @review.save
        @review.article.update(status: :inactive)
        redirect_to admin_articles_url, notice: 'Creation finish successfully.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def send_article_for_review
      authorize [:admin, @article]
      @article.active!
      redirect_to [:admin, @article], notice: 'Article sent for review'
    end

    def publish_article
      authorize [:admin, @article]
      @article.published!
      redirect_to [:admin, @article], notice: 'Article published'
    end
  
    private

    def load_models
      @article = Article.find(params[:article_id])
    end
    
    def review_params
      params.require(:review).permit(:article_id, :comment)
    end
  end
end

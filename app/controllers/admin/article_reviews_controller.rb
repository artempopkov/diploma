module Admin
  class ArticleReviewsController < AdminController

    def create
      result = CreateArticleReview.call(article_reviews_params: article_reviews_params)

      redirect_to admin_articles_url, notice: result.message
    end

    private

    def article_reviews_params
      params.require(:article_review).permit(:article_id, :comment, :status)
    end
  end
end

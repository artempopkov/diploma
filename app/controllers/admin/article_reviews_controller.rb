module Admin
  class ArticleReviewsController < AdminController
    after_action :verify_authorized
    
    def create
      if article_reviews_params[:status] == 'accepted'
        result = ArticleReviews::Accept.call(article_reviews_params: article_reviews_params)
      else
        result = ArticleReviews::Reject.call(article_reviews_params: article_reviews_params)
      end
      authorize [:admin, result.article_review]
      
      if result.success?
        redirect_to admin_article_url(result.article_review.article), notice: "Новость #{result.article_review.article.translated_status}"
      else
        flash[:error] = result.message
        redirect_to admin_articles_url
      end
    end

    private

    def article_reviews_params
      params.require(:article_review).permit(:article_id, :comment, :status, :moderator_id)
    end
  end
end

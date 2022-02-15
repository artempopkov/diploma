module Admin
  class ArticleReviewsController < AdminController

    def create
      if params[:status] == "accepted"
        result = AccepteArticleReview.call(article_reviews_params: article_reviews_params)
      else
        result = RejectArticleReview.call(article_reviews_params: article_reviews_params)
      end
      
      if result.success?
        redirect_to admin_article_url(result.article_review.article), notice: "Article review was successfully #{params[:status]}."
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

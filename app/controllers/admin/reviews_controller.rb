module Admin
  class ReviewsController < AdminController
    def new
      @review = Review.new
      @article = Article.find(params[:aid])
    end

    def create
      @review = Review.new(review_params)
      if @review.save
        @article.status = 'active'
        @article.save!
        redirect_to admin_articles_url, notice: "Review was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def load_models
      @article ||= Article.find(params[:article_id])
    end

    def review_params
      params.require(:review).permit(:article_id, :comment)
    end
  end
end

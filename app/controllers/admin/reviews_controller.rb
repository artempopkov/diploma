module Admin
  class ReviewsController < AdminController
    def new
      @review = Review.new
    end

    def create
      @review = Review.new(review_params)
      if @review.save
        @review.article.update(status: :inactive)
        redirect_to admin_articles_url, notice: "Review was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def review_params
      params.require(:review).permit(:article_id, :comment)
    end
  end
end

module ArticleReviews
  class Accept
    include Interactor

    def call
      ArticleReview.transaction do
        context.article_review = ArticleReview.create!(context.article_reviews_params)
        context.article_review.article.update!(status: 'accepted')
      end
    rescue StandardError => exception
      context.fail!(message: exception.message)
    end
  end
end

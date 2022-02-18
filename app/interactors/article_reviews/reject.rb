module ArticleReviews
  class Reject
    include Interactor

    def call
      ArticleReview.transaction do
        context.article_review = ArticleReview.create!(context.article_reviews_params)
        context.article_review.article.update!(edited: true) if context.article_review.article.published?
        context.article_review.article.update!(status: 'rejected')
      end
    rescue StandardError => exception
      context.fail!(message: exception.message)
    end
  end
end

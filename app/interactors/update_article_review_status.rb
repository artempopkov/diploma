class UpdateArticleReviewStatus
  include Interactor

  def call
    article_review = ArticleReview.new(context.article_reviews_params)
    if article_review.save
      context.article_review = article_review
    else
      context.fail!(message: "Fail to create article review")
    end
  end
end

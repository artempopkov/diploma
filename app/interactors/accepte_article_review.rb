class AccepteArticleReview
  include Interactor

  def call
    ArticleReview.transaction do
      article_review = ArticleReview.create!(context.article_reviews_params)
      article_review.article.update!(status: "accepted")
    end
  end
end

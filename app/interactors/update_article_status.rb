class UpdateArticleStatus
  include Interactor

  def call
    if context.article_review.article.update(status: context.article_review.status)
      context.message = "Article #{context.article_review.status} successfully"
    else
      context.fail!(message: "Fail to create article review")
    end
  end

  def rollback
    context.article_review.destroy
  end
end

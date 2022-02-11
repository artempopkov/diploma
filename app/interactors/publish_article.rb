class PublishArticle
  include Interactor

  def call
    if context.article.published!
      context.message = "Article published"
    else
      context.fail!(message: "Fail to published article")
    end
  end
end

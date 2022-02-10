class PrepareArticle
  include Interactor

  def call
    if context.article.prepared!
      context.message = "Article prepared"
    else
      context.fail!(message: "Fail to prepare article")
    end
  end
end

class PrepareArticle
  include Interactor

  def call
    context.article.status = 'prepared'

    if context.article.save
      context.message = "Article prepared"
    else
      context.fail!(message: "Fail to prepare article")
    end
  end
end

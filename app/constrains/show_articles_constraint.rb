class ShowArticlesConstraint
  def matches?(request)
    article = Article.find(request.params['id'])
    article.published?
  end
end

class ShowArticlesConstraint
  def matches?(request)
    articles_id = request.params['id'] || request.params['article_id']
    article = Article.find(articles_id)
    article.published?
  end
end

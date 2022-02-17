class HomeController < ApplicationController
  def index
    @articles = Article.published.order(:id).limit(30)
    @three_important_articles = Article.important.order(:id).last(3)
  end
end

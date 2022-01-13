class HomeController < ApplicationController
  def index
    @articles = Article.all
    @last_three_articles = Article.order(:id).last(3)
  end
end

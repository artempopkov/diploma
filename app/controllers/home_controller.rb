class HomeController < ApplicationController
  def index
    @query = Article.published.ransack(params[:query])
    @articles = @query.result.page(current_page).order(:published_at)
    @three_important_articles = Article.important.published.order(:published_at).last(4)
    @tranding_articles = Article.trending.limit(3)
  end

  def search
    index
    render :index
  end
end

class HomeController < ApplicationController
  def index
    @query = Article.published.ransack(params[:query])
    @articles = @query.result.page(current_page).order(:id)
    # @articles = Article.published.order(:id)
    @three_important_articles = Article.important.order(:id).last(3)
    @tranding_articles = Article.trending.limit(3)
  end

  def search
    index
    render :index
  end
end

class ArticlesController < ApplicationController
  before_action :load_models, only: %i[show]

  def index
    @articles = Article.order(:id)
  end

  def show
  end

  private

  def load_models
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :content)
  end
end

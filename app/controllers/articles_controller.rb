class ArticlesController < ApplicationController
  before_action :set_models, only: %i[show]

  def index
    @articles = Article.all
  end

  def show
  end

  private

  def set_models
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :content)
  end
end

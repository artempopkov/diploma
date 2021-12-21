class ArticlesController < ApplicationController
  before_action :set_models, only: %i[show]

  def index
    @articles = Article.order(:id)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Creation finish successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_models
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :content)
  end
end

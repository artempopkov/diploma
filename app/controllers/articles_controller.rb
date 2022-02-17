class ArticlesController < ApplicationController
  before_action :load_models, only: %i[show]
  before_action :tag_cloud

  def index
    @articles = Article.all
  end

  def show
  end

  def tag_cloud
    @tags = Article.tag_counts_on(:tags)
  end

  private

  def load_models
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :content, :avatar, :avatar_disable, :category_id, :tag_list, :status, :important)
  end
end


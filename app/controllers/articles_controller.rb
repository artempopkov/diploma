class ArticlesController < ApplicationController
  before_action :load_models, only: %i[show like]
  before_action :tag_cloud
  respond_to :js

  def show
    @latests_articles = Article.latest_published.order(created_at: :desc).limit(5)
  end

  def like
    case params[:format]
    when 'like'
      @article.liked_by current_user
    when 'unlike'
      @article.unliked_by current_user
    end
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


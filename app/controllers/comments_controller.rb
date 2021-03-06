class CommentsController < ApplicationController
  before_action :load_models, only: %i[destroy]
  after_action :verify_authorized

  def index
    @comments = Comment.order(id: :desc)
    authorize @comments
  end

  def create
    @comment = Comment.new(comment_params)
    authorize @comment
    if @comment.save
      respond_to :js
    else
      redirect_to article_url(@comment.article), alert: 'Поле комментария не может быть пустым'
    end
  end
  
  private

  def load_models
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :article_id, :user_id)
  end
end

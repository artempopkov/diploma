class CommentsController < ApplicationController
  before_action :load_models, only: %i[ destroy ]
  after_action :verify_authorized

  def index
    @comments = Comment.all
    authorize @comments
  end

  def create
    @comment = Comment.new(comment_params)
    authorize @comment

    if @comment.save
      redirect_to @comment.article, notice: "Comment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy

    redirect_to comments_url, notice: "Comment was successfully destroyed."
  end

  private

  def load_models
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :article_id, :user_id)
  end
end

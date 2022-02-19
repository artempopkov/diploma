module Admin
  class CommentsController < AdminController
    before_action :load_models, only: %i[destroy]
    after_action :verify_authorized

    def index
      @comments = Comments.page(current_page).order("created_at DESC")
      authorize @comments
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
end

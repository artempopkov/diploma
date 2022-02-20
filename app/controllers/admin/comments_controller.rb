module Admin
  class CommentsController < AdminController
    before_action :load_models, only: %i[destroy]

    def index
      respond_to do |format|
        format.html
        format.json { render json: CommentsDatatable.new(view_context) }
      end
    end

    def destroy
      @comment.destroy

      redirect_to admin_comments_url, notice: "Comment was successfully destroyed."
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

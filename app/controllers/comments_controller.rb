class CommentsController < ApplicationController
  def create
    @comment = Comment.new comment_params
    @comment.user_id = current_user.id

    respond_to do |format|
      format.js {
        if @comment.save
          @comments = Comment.where(post_id: @comment.post_id)
          render "comments/create"
        else
          Rails.logger.debug @comment.errors.messages
        end
      }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :post_id)
  end
end

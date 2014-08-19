class CommentsController < ApplicationController
  before_action :signed_in_user, only: :create

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    @entry = Entry.find(comment.entry_id)
    if comment.save!
      flash[:success] = "Comment posted!"
      redirect_to [@entry.user, @entry]
    else
      render [@entry.user, @entry]
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:comment, :entry_id)
    end

end
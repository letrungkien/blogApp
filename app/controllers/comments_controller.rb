class CommentsController < ApplicationController
  before_action :signed_in_user, only: :create

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @entry = Entry.find(@comment.entry_id)
    @user = @entry.user
    @comment_user = current_user
    @comments = Comment.on_entry(@entry)

    if @comment.save
      flash[:success] = "Comment posted!"
      redirect_to [@entry.user, @entry]
    else
      flash[:failed] = "Comment failed to post!"
      render 'entries/show'
    end
    
  end

  private

    def comment_params
      params.require(:comment).permit(:comment, :entry_id)
    end

end
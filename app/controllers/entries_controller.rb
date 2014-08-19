class EntriesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy 

  def new
    @entry = current_user.entries.build 
    @user = current_user
  end

  def create
    @entry = current_user.entries.build(entry_params)
    @user = current_user
    if @entry.save
      flash[:success] = "Entry created!"
      redirect_to root_url
    else
      render 'new'
    end 
  end

  def show
    @entry = Entry.find_by(id: params[:id])
    @poster = @entry.user
    @user = current_user
    @comments = Comment.on_entry(@entry)
    @comment = @entry.comments.build()
  end

  private
    
    def entry_params
      params.require(:entry).permit(:title, :body)
    end

    def correct_user 
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end

end
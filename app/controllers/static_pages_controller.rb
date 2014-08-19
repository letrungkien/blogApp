class StaticPagesController < ApplicationController
  def home
  	@feed_items = current_user.feed.paginate(page: params[:page]) if signed_in?
  end

  def about
  end

  def help
  end

  def contact
  end
end

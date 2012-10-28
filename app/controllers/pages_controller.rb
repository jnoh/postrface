class PagesController < ApplicationController

  def home
    @posts = Post.order("created_at DESC").page(params[:page]).per(20)
  end

end

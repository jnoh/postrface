class Dashboard::PostsController < ApplicationController
  before_filter :require_login
  before_filter :is_allowed?, :only => [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    if @post = current_user.posts.create(params[:post])
      current_user.touch
      redirect_to @post, :alert => "Nice. New post."
    else
      render :action => :edit
    end
  end

  def edit

  end

  def update
    @post.update_attributes(params[:post])
    redirect_to @post
  end

  def destroy
    @post.destroy
    redirect_to current_user
  end

  private

    def is_allowed?
      @post = Post.find(params[:id])
      redirect_to(current_user, :alert => "You can't do that...") unless current_user = @post.user 
    end
end

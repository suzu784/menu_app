class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @search = Post.ransack(params[:q])
    @posts = @search.result
    @posts_all = Post.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def analysis
    @posts = Post.all
    @today_posts = @posts.created_today
    @yesterday_posts = @posts.created_yesterday
    @this_week_posts = @posts.created_this_week
    @last_week_posts = @posts.created_last_week
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

end

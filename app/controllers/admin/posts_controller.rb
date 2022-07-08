class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @search = Post.ransack(params[:q])
    @posts = @search.result
    @posts_all = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
  
end

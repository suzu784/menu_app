class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    post = Post.find(params[:post_id])
    @favorite = current_customer.favorites.new(post_id: post.id)
    @favorite.save
    post.create_notification_by!(current_customer)
    render customer_post_path(@post)
  end
  
  def destroy
    post = Post.find(params[:post_id])
    @favorite = current_customer.favorites.find_by(post_id: post.id)
    @favorite.destroy
    render customer_post_path(@post)
  end
end

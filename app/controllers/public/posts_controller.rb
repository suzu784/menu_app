class Public::PostsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @post = Post.new
  end

  def index
    @search = Post.ransack(params[:q])
    @posts = @search.result
    @posts_all = Post.with_attached_post_image.page(params[:page]).per(6)
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @recipe = Recipe.new
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = '投稿を削除しました'
      redirect_to posts_path
    else
      flash.now[:notice] = '投稿を削除できませんでした'
      render :show
    end
  end

  def popular
    @popular_posts = Post.with_attached_post_image.sort {|a, b| b.favorited_customers.size <=> a.favorited_customers.size}
  end

  private

  def post_params
    params.require(:post).permit(:cook_name, :opinion, :star, :status, :post_image, :cooked_day, :media_url)
  end
end

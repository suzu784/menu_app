class Public::PostsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @post = Post.new
  end

  def index
    @search = Post.ransack(params[:q])
    @posts = @search.result
    @posts_all = Post.page(params[:page])
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to posts_path
    else
      render :new
      flash[notice] = "難易度を入力してください"
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
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:cook_name, :opinion, :star, :status, :post_image, :created_at)
  end
end

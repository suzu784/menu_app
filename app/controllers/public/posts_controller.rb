class Public::PostsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @post = Post.new
  end

  def index
    @search = Post.ransack(params[:q])
    @posts = @search.result.includes(:customer).page(params[:page]).per(8)
    if params[:tag_ids]
      @posts = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_posts = Tag.find_by(name: key).posts
          @posts = @posts.empty? ? tag_posts : @posts & tag_posts
        end
      end
    end
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
    if @post.update(post_params)
      sleep(3) #S3への画像反映のタイムラグを考慮して3秒待機
      redirect_to post_path(@post)
    else
      render :edit
    end
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
    @popular_posts = Post.includes(:customer).sort {|a, b| b.favorited_customers.size <=> a.favorited_customers.size}
  end

  private

  def post_params
    params.require(:post).permit(:cook_name, :opinion, :star, :status, :post_image, :cooked_day, :media_url, tag_ids: [])
  end
end

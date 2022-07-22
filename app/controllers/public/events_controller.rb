class Public::EventsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @post = Post.new
    render plain: render_to_string(partial: 'form_new', layout: false, locals: { post: @post })
  end

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      respond_to do |format|
        format.html { redirect_to events_path }
      end
    else
      flash.now[:notice] = '※未入力箇所があります'
      render :index
    end
  end

  def post_params
    params.require(:post).permit(:cook_name, :opinion, :created_at, :media_url)
  end
end

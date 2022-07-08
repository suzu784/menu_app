class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @search = Customer.ransack(params[:q])
    @customers = @search.result
    @customers_ = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to customer_path(@customer)
  end

  def favorites
    
    @customer = Customer.find(params[:id])
    favorites= Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def followings
    customer = Customer.find(params[:customer_id])
		@customers = customer.followings
  end

  def followers
    customer = Customer.find(params[:customer_id])
		@customers = customer.followers
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :special_dish, :customer_image)
  end
end

class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_user, only: [:edit]

  def index
    @search = Customer.ransack(params[:q])
    @customers = @search.result
    @customers_all = Customer.page(params[:page]).per(5)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = '更新しました'
      redirect_to customer_path(@customer)
    else
      flash.now[:notice] = '更新できませんでした'
      render :edit
    end
  end

  def favorites
    favorites= Favorite.where(customer_id: params[:id]).pluck(:post_id)
    @favorite_posts = Post.where(id: favorites).page(params[:page])
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

  def ensure_guest_user
    @customer = current_customer
    if @customer.last_name == "guestuser"
      redirect_to customers_path, notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません'
    end
  end
end

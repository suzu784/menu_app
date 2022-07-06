class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @customers = Customer.all
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
  end
  
  def followings
    
  end
  
  def followers
    
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :special_dish, :customer_image)
  end
end

class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  
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
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to root_path
  end
  
  def confirm
  end
  
  def withdraw
    @customer = Customer.find(params[:customer_id])
    @customer.update(is_deleted: true)
    reset_session
    redirect_to admin_root_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :special_dish)
  end
end

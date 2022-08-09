class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @search = Customer.ransack(params[:q])
    @customers = @search.result
    @customers_all = Customer.page(params[:page])
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
    redirect_to admin_customer_path(@customer)
  end

  def confirm
  end

  def withdraw
    @customer = Customer.find(params[:customer_id])
    @customer.update(is_deleted: true)
    redirect_to admin_root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :introduction)
  end
end

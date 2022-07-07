class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  def create
    customer = Customer.find(params[:customer_id])
    current_customer.follow(customer)
		redirect_to request.referer
  end

  def destroy
    customer = Customer.find(params[:customer_id])
    current_customer.unfollow(customer)
		redirect_to request.referer
  end
end

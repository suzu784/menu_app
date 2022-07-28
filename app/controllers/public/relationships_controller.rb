class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @customer = Customer.find(params[:customer_id])
    current_customer.follow(@customer)
    @customer.create_notification_follow!(current_customer)
    redirect_to customer_path(@customer)
  end

  def destroy
    @customer = Customer.find(params[:customer_id])
    current_customer.unfollow(@customer)
    redirect_to customer_path(@customer)
  end
end

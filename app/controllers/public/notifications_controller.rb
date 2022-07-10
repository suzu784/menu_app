class Public::NotificationsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @notifications = current_customer.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
  
  def destroy_all
    @notifications = current_customer.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end

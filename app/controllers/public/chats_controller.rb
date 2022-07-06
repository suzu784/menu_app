class Public::ChatsController < ApplicationController
  before_action :authenticate_customer!
  
  def show
  end
end

class Public::PostCommentsController < ApplicationController
  before_action :authenticate_customer!
  
end

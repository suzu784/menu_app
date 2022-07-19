class Public::HomesController < ApplicationController
  before_action :authenticate_customer!, only: [:index]

  def top
  end

  def about
  end

  def timeline
     @posts_all = Post.with_attached_post_image
     @customer = Customer.find(current_customer.id)
     # フォローしているカスタマーを取得
     @follow_customers = @customer.followings
     # フォローユーザーのツイートを表示
     @posts = @posts_all.where(customer_id: @follow_customers).order("created_at DESC").page(params[:page]).per(5)
  end
end

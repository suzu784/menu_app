# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to customers_path, notice: 'ゲストユーザーでログインしました'
  end

  protected

  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])
    return if !@customer
    if @customer.valid_password?(params[:customer][:password]) && (@customer.active_for_authentication? == false)
      flash[:alert] = "退会済みです。再度ご登録をしてご利用ください。"
      redirect_to new_customer_registration_path
    end
  end

  def after_sign_in_path_for(resource)
    events_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

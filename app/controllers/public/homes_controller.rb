class Public::HomesController < ApplicationController
  before_action :authenticate_customer!, only: [:index]

  def top
  end

  def about
  end

end

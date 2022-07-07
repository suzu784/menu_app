class Public::EventsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @events = Event.all
  end
end

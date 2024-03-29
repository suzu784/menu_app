class Public::EventsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @event = Event.new
    render plain: render_to_string(partial: 'form_new', layout: false, locals: { event: @event })
  end

  def index
    @customer = current_customer
    @events = Event.where(customer_id: @customer.id)
  end

  def create
    @event = Event.new(event_params)
    @event.customer_id = current_customer.id
    if @event.save
      redirect_to events_path
    else
      flash.now[:notice] = '※未入力箇所があります'
      render :index
    end
  end

  def update
    starttime = params[:start]
    endtime = params[:end]
    event = Event.find(params[:id])
    event.update(start: starttime, end: endtime)
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
  end

  def event_params
    params.require(:event).permit(:start, :end, :title)
  end
end

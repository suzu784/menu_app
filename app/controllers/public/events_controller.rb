class Public::EventsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @event = Event.new
    render plain: render_to_string(partial: 'form_new', layout: false, locals: { event: @event })
  end

  def index
    @events = Event.all
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      respond_to do |format|
        format.html { redirect_to events_path }
      end
    else
      flash.now[:notice] = '※未入力箇所があります'
      render :index
    end
  end

  def event_params
    params.require(:event).permit(:start, :end, :title)
  end
end

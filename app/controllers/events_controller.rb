class EventsController < ApplicationController
  def index
    @events = Event.all.order('created_at DESC')
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    event = Event.find(params[:id])
    if event.destroy
      redirect_to events_path
    else
      render :index
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_path
    else
      render :edit
    end
  end

  private
  def event_params
    params.require(:event).permit(:event_name, :event_text, :prefecture, :city, :block, :building, :date, :phone).merge(admin_id: current_admin.id)
  end
end

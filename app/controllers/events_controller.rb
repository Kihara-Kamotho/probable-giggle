# frozen_string_literal: true

class EventsController < ApplicationController # rubocop:disable Style/Documentation
  before_action :set_department, except: %i[show edit update destroy]
  before_action :set_event, except: %i[index new create]

  def index
    @events = @department.events
  end

  def new
    @event = @department.events.new
  end

  def create
    @event = @department.events.build(event_params)

    respond_to do |format|
      if @event.save
        # Schedule the event reminder job
        EventReminderJob.set(wait_until: @event.date - 1.day).perform_later(@event)

        flash[:notice] = 'Event was successfully created.'
        format.html { redirect_to event_path(@event) }
        format.turbo_stream
      else
        flash[:alert] = 'Error creating event.'
        render :new
      end
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @event.update(event_params)
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to event_path(@event) }
        format.turbo_stream
      else
        flash[:alert] = 'Error updating event.'
        render :edit
      end
    end
  end

  def destroy
    respond_to do |format|
      flash[:notice] = 'Event was successfully deleted.'
      format.html { redirect_to department_path(@department) }
      format.turbo_stream
    end
  end

  private

  def set_department
    @department = Department.find(params[:department_id])
  end

  def event_params
    params.require(:event).permit(:name, :date)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end

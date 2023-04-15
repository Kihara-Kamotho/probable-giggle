# frozen_string_literal: true

class GuestsController < ApplicationController # rubocop:disable Style/Documentation
  before_action :set_event, except: %i[show edit update destroy]
  before_action :set_guest, except: %i[index new create]

  def index
    @guests = @event.guests
  end

  def new
    @guest = @event.guests.new
  end

  def create
    @guest = @event.guests.new(guest_params)

    respond_to do |format|
      if @guest.save
        flash[:notice] = 'Guest created successfully.'
      else
        flash[:alert] = 'Failed to create guest.'
        render :new
      end
    end
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def guest_params
    params.require(:guest).permit(:name)
  end

  def set_guest
    @guest = Guest.find(params[:id])
  end
end

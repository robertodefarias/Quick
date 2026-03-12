class TripsController < ApplicationController
  before_action :authenticate_user!

  def index
    @trips = current_user.trips
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = current_user.trips.build(trip_params)

    if @trip.save
      # cria chat automaticamente
      chat = Chat.create!(
        user: current_user,
        trip: @trip
      )

      # primeira pergunta automática
      Message.create!(
        chat: chat,
        role: "user",
        content: "Tell me the main tourist attractions in #{@trip.city}"
      )

      redirect_to chat_path(chat)

    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @trip = current_user.trips.find(params[:id])
  end

  private

  def trip_params
    params.require(:trip).permit(:city, :content)
  end
end

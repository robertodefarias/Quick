class TripsController < ApplicationController
  before_action :authenticate_user!

  def index
    @trips = current_user.trips
  end

  def new
    @trip = Trip.new
  end

  def show
    @trip = current_user.trips.find(params[:id])
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
      user_message = Message.create!(
        chat: chat,
        role: "user",
        content: "Plan a short trip to #{@trip.city}. #{@trip.content}"
      )

      # chama a IA
      response = RubyLLM.chat.ask(user_message.content)

      # salva resposta da IA
      Message.create!(
        chat: chat,
        role: "assistant",
        content: response.content
      )

      redirect_to chat_path(chat)

    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @trip = current_user.trips.find(params[:id])
    @trip.destroy
    redirect_to trips_path, notice: "Trip deleted"
  end

  private

  def trip_params
    params.require(:trip).permit(:city, :content)
  end
end

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
      chat = Chat.create!(
        user: current_user,
        trip: @trip
      )

      # Mensagem inicial Automatica
      user_message = Message.create!(
        chat: chat,
        role: "user",
        content: "Criando um roteiro resumido para visitar #{@trip.city}. #{@trip.content}"
      )

      # chamada da IA
      response = RubyLLM.chat
                        .with_instructions("You are a travel assistant.")
        .ask(user_message.content)

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

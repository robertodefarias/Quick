class ChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    @trip = Trip.find(params[:chat][:trip_id])
    @chat = Chat.new(user: current_user, trip: @trip)

    if @chat.save
      redirect_to chat_path(@chat)
    else
      redirect_to root_path, alert: "Error starting chat."
    end
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new # -----> para o formulário da IA depois
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to root_path, notice: "Travel history deleted."
  end
end

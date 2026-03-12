class ChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    @trip = Trip.find(params[:chat][:trip_id])

    @chat = @trip.chats.first || Chat.create!(
      trip: @trip,
      user: current_user
    )

    redirect_to chat_path(@chat)
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new # ------> para o formulário da IA depois
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to root_path, notice: "Travel history deleted."
  end
end

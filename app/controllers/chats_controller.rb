class ChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    @trip = Trip.find(params[:chat][:trip_id])

    # se for cidade seed (user_id nil) cria chat novo
    if @trip.user_id.nil?

      @chat = Chat.create!(
        trip: @trip,
        user: current_user
      )

    # se for trip do usuário reutiliza chat
    else

      @chat = @trip.chats.find_by(user: current_user) ||
              Chat.create!(trip: @trip, user: current_user)

    end

    # mensagem inicial da IA
    if @chat.messages.empty?

      intro = <<~TEXT
      Welcome! Here is a quick guide for visiting #{@trip.city}:

      #{@trip.content}

      Ask me anything about attractions, food or travel tips!
      TEXT

      Message.create!(
        chat: @chat,
        role: "assistant",
        content: intro
      )

    end

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

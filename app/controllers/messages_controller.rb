class MessagesController < ApplicationController
  before_action :authenticate_user!

  SYSTEM_PROMPT = "You are an expert travel assistant.
  Provide travel suggestions using Markdown format.
  Use:
  - bullet point lists
  - section titles
  - short paragraphs

  Keep answers concise."

  def create
    @chat = current_user.chats.find(params[:chat_id])
    @trip = @chat.trip

    # mensagem do usuário
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save

      response = RubyLLM.chat
        .with_instructions(instructions)
        .ask(@message.content)

      Message.create!(
        role: "assistant",
        content: response.content,
        chat: @chat
      )

      redirect_to chat_path(@chat)

    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def trip_context
    "The user is planning a trip to #{@trip.city}. #{@trip.content}"
  end

  def instructions
    [SYSTEM_PROMPT, trip_context].compact.join("\n\n")
  end
end

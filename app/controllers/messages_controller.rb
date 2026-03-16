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

    @message = Message.create!(
      chat: @chat,
      role: "user",
      content: params[:message][:content]
    )

    response = RubyLLM.chat
      .with_instructions(instructions)
      .ask(conversartion_history)

    @ai_message = Message.create!(
      chat: @chat,
      role: "assistant",
      content: response.content
    )

    respond_to do |format|
      format.turbo_stream
    end
  end

  def conversartion_history
    @chat.messages.last(10).map do |message|
      {
        role: message.role,
        content: message.content
      }
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

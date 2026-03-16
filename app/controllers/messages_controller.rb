class MessagesController < ApplicationController
  before_action :authenticate_user!

  SYSTEM_PROMPT = "Você é um assistente especialista em planejamento de viagens.
    Responda sempre em português.
    Formate todas as respostas usando Markdown válido.

    Regras obrigatórias:
    - Use ## para títulos principais
    - Use ### para subtítulos
    - Use listas com '-'
    - Use parágrafos curtos

    Quando criar roteiros:
    - Separe por dias
    - Organize em Manhã / Tarde / Noite
    - Use listas para atividades

    Evite textos longos em bloco.
    Exemplo de resposta:

    ## Roteiro de 1 dia – Paris

    ### Manhã
    - Torre Eiffel
    - Café da manhã em Montmartre"

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

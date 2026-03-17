class GenerateTripPlanJob < ApplicationJob
  queue_as :default

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

    ## Roteiro de 1 dia - Paris

    ### Manhã
    - Torre Eiffel
    - Café da manhã em Montmartre"

  def perform(chat_id)
    chat = Chat.find(chat_id)

    user_message = chat.messages.where(role: "user").last
    ai_message = chat.messages.where(role: "assistant").last

    ruby_llm_chat = RubyLLM.chat
    ruby_llm_chat.with_instructions(SYSTEM_PROMPT)

    ruby_llm_chat.ask(user_message.content) do |chunk|
      next if chunk.content.blank?

      ai_message.update!(
        content: ai_message.content + chunk.content
      )

      Turbo::StreamsChannel.broadcast_replace_to(
        chat,
        target: "message_#{ai_message.id}",
        partial: "messages/message",
        locals: { message: ai_message }
      )
    end
  end
end

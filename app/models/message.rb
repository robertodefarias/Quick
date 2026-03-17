class Message < ApplicationRecord
  belongs_to :chat

  validates :content, presence: true, if: -> { role == "user" }
  validates :role, presence: true

  after_create_commit :broadcast_append_to_chat
  after_update_commit :broadcast_replace_to_chat

  private

  def broadcast_append_to_chat
    broadcast_append_to(
      chat,
      target: "messages",
      partial: "messages/message",
      locals: { message: self }
    )
  end

  def broadcast_replace_to_chat
    broadcast_replace_to(
      chat,
      target: ActionView::RecordIdentifier.dom_id(self),
      partial: "messages/message",
      locals: { message: self }
    )
  end
end

class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  # se o usuário deletar o chat, as mensagens da IA devem sumir juntas
  has_many :messages, dependent: :destroy
  # validações para garantir que nenhum chat seja criado "vazio"
  validates :user, presence: true
  validates :trip, presence: true
end

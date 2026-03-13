class Trip < ApplicationRecord
  belongs_to :user, optional: true
  has_many :chats, dependent: :destroy

  validates :city, presence: true
  validates :content, presence: true
end

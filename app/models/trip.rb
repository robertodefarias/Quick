class Trip < ApplicationRecord
  belongs_to :user, optional: true
  has_many :chats, dependent: :destroy
end

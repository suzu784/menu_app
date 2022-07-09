class Room < ApplicationRecord
  has_many :customer_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
end

class PostComment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  has_many :notifications, dependent: :destroy

  with_options presence: true do
    validates :comment
  end
end

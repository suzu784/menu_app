class Recipe < ApplicationRecord
  belongs_to :customer
  belongs_to :post

  validates :content, presence: true

  has_many :tags, dependent: :destroy
  accepts_nested_attributes_for :tags, allow_destroy: true

  has_many_attached :recipe_images

  enum category: { japanese_food: 0, western_food: 1, chinese_food: 2 }
  enum status: { published: 0, draft: 1 }

end

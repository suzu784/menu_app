class Recipe < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  has_many :recipe_ingredients, dependent: :destroy
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true

  enum status: { published: 0, draft: 1 }
end

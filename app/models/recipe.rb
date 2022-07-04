class Recipe < ApplicationRecord
  belongs_to :post
  has_many :how_to_makes, dependent: :destroy
end

class Post < ApplicationRecord
  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
end

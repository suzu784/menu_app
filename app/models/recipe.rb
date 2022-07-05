class Recipe < ApplicationRecord
  belongs_to :post
  has_many :how_to_makes, dependent: :destroy
  
  has_one_attached :recipe_image

  enum category: { japanese_food: 0, western_food: 1, chinese_food: 2 }
  
  def get_recipe_image(width, height)
    unless recipe_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpeg')
      recipe_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    recipe_image.variant(resize_to_limit:[width, height]).processed
  end
end

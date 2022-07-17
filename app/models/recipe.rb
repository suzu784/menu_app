class Recipe < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  belongs_to :event

  validates :content, presence: true

  has_many :tags, dependent: :destroy
  accepts_nested_attributes_for :tags, allow_destroy: true

  has_many_attached :recipe_images

  enum category: { japanese_food: 0, western_food: 1, chinese_food: 2 }
  enum status: { published: 0, draft: 1 }

  def get_recipe_images(width, height)
    unless recipe_images.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpeg')
      recipe_images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    recipe_images.variant(resize_to_limit: [width, height]).processed
  end

end

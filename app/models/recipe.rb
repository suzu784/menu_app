class Recipe < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  belongs_to :event, optional: true

  has_many :tags, dependent: :destroy
  accepts_nested_attributes_for :tags, allow_destroy: true

  has_one_attached :recipe_image

  enum status: { published: 0, draft: 1 }

  def get_recipe_image(width, height)
    unless recipe_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpeg')
      recipe_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    recipe_image.variant(resize_to_limit: [width, height]).processed
  end

end

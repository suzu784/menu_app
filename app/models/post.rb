class Post < ApplicationRecord
  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_one_attached :post_image
  
  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpeg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit:[width, height]).processed
  end
  
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
end

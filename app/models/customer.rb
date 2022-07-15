class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :recipes, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :favorites, dependent: :destroy

  has_many :customer_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :customer_rooms, dependent: :destroy

  has_many :active_notifications, class_name: "Notification", foreign_key: :visiter_id, dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: :visited_id, dependent: :destroy

  has_one_attached :customer_image

  def get_customer_image(width, height)
    unless customer_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpeg')
      customer_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    customer_image.variant(resize_to_limit:[width, height]).processed
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def follow(customer)
    relationships.create(followed_id: customer.id)
  end

  def unfollow(customer)
    relationships.find_by(followed_id: customer.id).destroy
  end

  def following?(customer)
    followings.include?(customer)
  end

  #フォロー時の通知
  def create_notification_follow!(current_customer)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ?", current_customer.id, id, 'follow'])
    if temp.blank?
      notification = current_customer.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def self.guest
  find_or_create_by!(last_name: 'guestuser' ,email: 'guest@example.com') do |customer|
    customer.password = SecureRandom.urlsafe_base64
    customer.last_name = "guestuser"
    end
  end

  def full_name
    first_name.to_s + "" + last_name.to_s
  end
end

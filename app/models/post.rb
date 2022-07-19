class Post < ApplicationRecord
  belongs_to :customer
  belongs_to :event, optional: true
  has_many :post_comments, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customer
  has_many :notifications, dependent: :destroy

  # 今週の投稿数の合計を表示させる
  scope :created_day_ago, -> (number) { where(created_at: number.day.ago.all_day) }
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { created_day_ago(1) } # 前日
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..1.week.ago.end_of_day) } # 今週
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } # 先週

  # 1日毎の投稿数の合計を表示させる
  scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) } # 2日前
  scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) } # 3日前
  scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) } # 4日前
  scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) } # 5日前
  scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) } #日前

  with_options presence: true do
    validates :star
    validates :post_image
    validates :cook_name
  end

  has_one_attached :post_image

  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpeg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  # いいね通知
  def create_notification_by(current_customer)
    notification = current_customer.active_notifications.new(
      post_id: id,
      visited_id: customer_id,
      action: "favorite"
    )
    notification.save if notification.valid?
  end

  # コメント通知
  def create_notification_comment!(current_customer, post_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = PostComment.select(:customer_id).where(post_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_customer, post_comment_id, temp_id['customer_id'])
     end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_customer, post_comment_id, customer_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_customer, post_comment_id, visited_id)
    # コメントは複数回することが考えられるため、1つの投稿に複数回通知する
    notification = current_customer.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: "comment"
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end

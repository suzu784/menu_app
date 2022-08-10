# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_data = Admin.find_by(email: 'menu@com')
if admin_data.nil?
   Admin.create!(
   email: 'menu@com',
   password: 'menuapp'
   )
end

post = Post.create!(
                  cook_name: '豚汁',
                  opinion: 'ぜひ作ってみてください',
                  star: 5,
                  customer_id: 1,
                  cooked_day: "2022/07/26"
                  )
post.post_image.attach(io: File.open(Rails.root.join('app/assets/images/misosoup.JPG')),
                  filename: 'misosoup.JPG')

tags = %w(栄養満点 ヘルシー スタミナ 時短 甘い 辛い)
tags.each do |tag|
  Tag.find_or_create_by(name: tag)
end
FactoryBot.define do
  factory :post do
    cook_name { Faker::Lorem.characters(number: 5) }
    opinion { Faker::Lorem.characters(number: 20) }
    star { 3.5 }
    post_image { Rack::Test::UploadedFile.new("spec/fixtures/files/test.jpg", "image/jpg") }
    customer
  end
end
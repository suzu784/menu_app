FactoryBot.define do
  factory :post do
    cook_name { Faker::Lorem.characters(number: 5) }
    opinion { Faker::Lorem.characters(number: 20) }
    star { Fa}
    customer
  end
end
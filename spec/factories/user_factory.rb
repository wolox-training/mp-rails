FactoryBot.define do
  factory :user do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Faker::Lorem.characters(10) }
  end
end

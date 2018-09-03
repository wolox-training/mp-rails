FactoryBot.define do
  factory :book do
    genre { Faker::Lorem.words(1) }
    author { Faker::Name.name }
    image { Faker::Lorem.words }
    title { Faker::Lorem.words }
    publisher { Faker::Name.name }
    year { Faker::Number.number(4) }
  end
end

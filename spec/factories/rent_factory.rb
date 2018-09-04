FactoryBot.define do
  factory :rent do
    book
    user
    from { Time.zone.today }
    to { Time.zone.tomorrow }
  end
end

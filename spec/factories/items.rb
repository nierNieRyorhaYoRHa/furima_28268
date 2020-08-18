FactoryBot.define do
  factory :item do
    name        { Faker::Games::Zelda.item }
    explanation { Faker::TvShows::Friends.quote }
    category_id { 2 }
    status_id   { 2 }
    delivery_id { 2 }
    area_id     { 2 }
    days_id     { 2 }
    price       { Faker::Number.between(from: 300, to: 9999999) }
    association :user
  end
end


FactoryBot.define do
  factory :item do
    name        { 'zelda' }
    explanation { 'Legend of zelda' }
    category_id { 2 }
    status_id   { 2 }
    delivery_id { 2 }
    area_id     { 2 }
    days_id     { 2 }
    price       { 12_345 }
    association :user
  end
end

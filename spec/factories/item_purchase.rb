FactoryBot.define do
  factory :item_purchase do
    card_token         { 'zelda' }
    postal_code   { '123-4567' }
    area_id       { '48' }
    city          { '中央ハイラル' }
    house_number  { 'ハイラル城' }
    building_name { '時の神殿' }
    phone_number  { '01234567890' }
    item_id       { 1 }
    user_id       { 1 }
  end
end

FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { '夜神' }
    first_name            { '月' }
    last_name_kana        { 'ヤガミ' }
    first_name_kana       { 'ライト' }
    birthday              { 19_990_101 }
  end
end

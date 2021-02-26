FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name            { '陸太郎' }
    last_name             { '山田' }
    first_reading         { 'リクタロウ' }
    last_reading          { 'ヤマダ' }
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
FactoryBot.define do
  factory :item_purchase do
    postal_code { '123-4567' }
    delivery_area_id { 2 }
    municipality { '横浜市緑区' }
    street_address { '青山1-1-1' }
    building_name { '柳ハイツ103' }
    phone_number { '09012345678' }
    association :user
    association :item
  end
end
class ItemPurchase
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :postal_code, :delivery_area_id, :municipality, :street_address, :building_name, :phone_number

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :user_id, :item_id, :municipality, :street_address, :token
  end

  validates :delivery_area_id, numericality: { other_than: 1 }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, delivery_area_id: delivery_area_id, municipality: municipality, street_address: street_address, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :delivery_area
  belongs_to :delivery_time

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
  validates :category_id,      numericality: { other_than: 1 }
  validates :condition_id,     numericality: { other_than: 1 }
  validates :delivery_fee_id,  numericality: { other_than: 1 }
  validates :delivery_area_id, numericality: { other_than: 1 }
  validates :delivery_time_id, numericality: { other_than: 1 }
  end

  with_options presence: true do
    validates :name
    validates :item_desc
    validates :image
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "Out of setting range" }
  end
  
  validates :price, format: { with: /\A[0-9]+\z/, message: "Half-width number" }
end

class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :conditon
  belongs_to :delivery_fee
  belongs_to :delivery_area
  belongs_to :delivery_time

  belongs_to :user
  has_one_attached :image
end

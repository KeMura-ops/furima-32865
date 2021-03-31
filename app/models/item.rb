class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :delivery_area
  belongs_to :delivery_time

  belongs_to :user
  has_one    :order
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :item_desc
    validates :image
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "が設定額の範囲外です" }

    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :condition_id
      validates :delivery_fee_id
      validates :delivery_area_id
      validates :delivery_time_id
    end
  end

  with_options format: { with: /\A[0-9]+\z/, message: "を半角数値で入力してください" } do
    validates :price
  end
end

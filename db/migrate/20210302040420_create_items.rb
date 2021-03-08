class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :name,             null: false
      t.text       :item_desc,        null: false
      t.integer    :category_id,      null: false
      t.integer    :condition_id,     null: false
      t.integer    :delivery_fee_id,  null: false
      t.integer    :delivery_area_id, null: false
      t.integer    :delivery_time_id, null: false
      t.integer    :price,            null: false
      t.references :user,             foreign_key: true
      t.timestamps
    end
  end
end

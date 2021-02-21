## テーブル設計

## users テーブル

| Column             | Type   | Options                  |
|--------------------|--------|--------------------------|
| nickname           | string | null:false               |
| email              | string | null:false, unique: true |
| encrypted_password | string | null:false               |
| first_name         | string | null:false               |
| last_name          | string | null:false               |
| first_zenkaku      | string | null:false               |
| last_zenkaku       | string | null:false               |
| birthday           | date   | null:false               |



### Association
- has_many :items
- has_many :orders

## items テーブル

| Column             | Type       | Options           |
|--------------------|------------|-------------------|
| name               | string     | null:false        |
| item_desc          | text       | null:false        |
| category_id        | integer    | null:false        |
| condition_id       | integer    | null:false        |
| delivery_fee_id    | integer    | null:false        |
| delivery_area_id   | integer    | null:false        |
| delivery_time_id   | integer    | null:false        |
| price              | integer    | null:false        |
| user               | references | foreign_key: true |




### Association
- belongs_to :user
- has_one    :order

## orders テーブル

| Column             | Type       | Options           |
|--------------------|------------|-------------------|
| user               | references | foreign_key: true |
| item               | references | foreign_key: true |



### Association
- belongs_to :user
- belongs_to :item
- has_one    :address

## addresses テーブル

| Column           | Type       | Options           |
|------------------|------------|-------------------|
| postal_code      | string     | null:false        |
| delivery_area_id | integer    | null:false        |
| municipality     | string     | null:false        |
| street_address   | string     | null:false        |
| building_name    | string     |                   |
| phone_number     | string     | null:false        |
| order            | references | foreign_key: true |



### Association
- belongs_to :order

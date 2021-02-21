## テーブル設計

## users テーブル

| Column             | Type     | Options    |
|--------------------|----------|------------|
| nickname           | string   | null:false |
| email              | string   | null:false |
| encrypted_password | string   | null:false |
| first_name         | string   | null:false |
| last_name          | string   | null:false |
| first_zenkaku      | string   | null:false |
| last_zenkaku       | string   | null:false |
| birthday           | datetime | null:false |



### Association
- has_many :items
- has_many :orders

## items テーブル

| Column             | Type       | Options           |
|--------------------|------------|-------------------|
| name               | string     | null:false        |
| item_desc          | string     | null:false        |
| category           | string     | null:false        |
| condition          | string     | null:false        |
| delivery_fee       | integer    | null:false        |
| delivery_area      | string     | null:false        |
| delivery_time      | datetime   | null:false        |
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

| Column        | Type       | Options           |
|---------------|------------|-------------------|
| postal_code   | string     | null:false        |
| delivery_area | string     | null:false        |
| municipality  | string     | null:false        |
| address       | string     | null:false        |
| phone_number  | string     | null:false        |
| orders        | references | foreign_key: true |



### Association
- belongs_to :order

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname | string | null: false |
| email    | string | null: false |
| encrypted_password | string | null: false |
| last_name | string | null: false |
| first_name | string | null: false |
| last_name_kana | string | null: false |
| first_name_kana | string | null: false |
| birthday | date | null: false |


### Association

- has_many :items
- has_many :trades
- has_many :comments

## items テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |
| explanation | text | null: false |
| price | string | null: false |
| user_id | references | null: false, foreign_key: true |
| category_id | integer | null: false |
| status_id | integer | null: false |
| delivery_id | integer | null: false |
| area_id | integer | null: false |
| days_id | integer | null: false |

### Association

- belongs_to :user
- belongs_to :purchase
- has_many :comments
- belongs_to :address

## addresses テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| postal_code | string | null: false |
| prefecture | integer | null: false |
| city | string | null: false |
| house_number | string | null: false |
| building_name | string |             |
| phone_number | string | null: false |
| item_id | references | null: false, foreign_key: true |



### Association

- belongs_to :item

## purchases テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |


### Association

- belongs_to :item
- belongs_to :user

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | text | null: false, foreign_key: true |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |


### Association

- belongs_to :item
- belongs_to :user
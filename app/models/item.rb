class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery
  belongs_to_active_hash :area
  belongs_to_active_hash :days

  with_options presence: true do
    validates :images
    validates :name, length: { maximum: 40 }
    validates :explanation, length: { maximum: 1000 }
    validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :status_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :delivery_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :area_id, numericality: { other_than: 0, message: 'を選択してください' }
    validates :days_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end

  belongs_to :user
  has_one :purchase
  has_many :comments
  has_many_attached :images
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations
end

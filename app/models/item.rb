class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery
  belongs_to_active_hash :area
  belongs_to_active_hash :days

  # 空の投稿を保存できないようにする
  # validates :title, :text, :genre, presence: true

  # ジャンルの選択が「--」の時は保存できないようにする
  with_options presence: true do
    validates :image
    validates :name, length: { maximum: 40 }
    validates :explanation, length: { maximum: 1000 }
    validates :category_id, numericality: { other_than: 1, message: 'Select' }
    validates :status_id, numericality: { other_than: 1, message: 'Select' }
    validates :delivery_id, numericality: { other_than: 1, message: 'Select' }
    validates :area_id, numericality: { other_than: 0, message: 'Select' }
    validates :days_id, numericality: { other_than: 1, message: 'Select' }
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end

  belongs_to :user
  has_one :purchase
  has_many :comments
  has_one_attached :image
end

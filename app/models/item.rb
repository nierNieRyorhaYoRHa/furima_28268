class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery
  belongs_to_active_hash :area
  belongs_to_active_hash :days


  #空の投稿を保存できないようにする
  # validates :title, :text, :genre, presence: true

  #ジャンルの選択が「--」の時は保存できないようにする
  # validates :category_id, numericality: { other_than: 0 } 

  belongs_to :user
  has_one :purchase
  has_many :comments
  has_one_attached :image

end

class Tag < ApplicationRecord
  has_many :item_tag_relations
  has_many :items, through: :item_tag_relations
  has_many :item_teg_brands, through: :item_tag_relations, source: :item


  validates :brand, uniqueness: true
end

class Tag < ApplicationRecord
  has_many :item_tag_relations
  has_many :items, through: :item_tag_relations

  validates :brand, uniqueness: true
end

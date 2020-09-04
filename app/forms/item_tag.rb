class ItemTag
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :name, :explanation, :category_id, :status_id, :delivery_id, :area_id, :days_id, :price, :brand, :images

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

  def save
    item = Item.create(
      name: name, 
      explanation: explanation, 
      category_id: category_id, 
      status_id: status_id, 
      delivery_id: delivery_id, 
      area_id: area_id, 
      days_id: days_id, 
      price: price, 
      user_id: user_id, 
      images: images)
    tag = Tag.where(brand: brand).first_or_initialize
    tag.save
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

end

class ItemPurchase
  include ActiveModel::Model

  attr_accessor :item_id, :user_id, :purchase_id, :postal_code, :area_id, :city, :house_number, :building_name, :phone_number, :token

  VALID_postal_code_REGEX = /\A\d{3}[-]\d{4}\z/.freeze
  VALID_phone_number_REGEX = /\A\d{10}\z|\A\d{11}\z/.freeze
  # VALID_phone_number_REGEX =  /\A(0{1}\d{9,10})\z/.freeze

  with_options presence: true do
    validates :token
    validates :postal_code, format: { with: VALID_postal_code_REGEX }
    validates :area_id, numericality: { other_than: 0, message: 'Select' }
    validates :city
    validates :house_number
    validates :phone_number, format: { with: VALID_phone_number_REGEX }
  end

  def save
    return false if invalid?

    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(purchase_id: purchase.id, postal_code: postal_code, area_id: area_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number)
  end
end

class ItemPurchase 


  include ActiveModel::Model

  attr_accessor :item_id, :user_id, :purchase_id, :postal_code, :area_id, :city, :house_number, :building_name, :phone_number, :hoge


  VALID_postal_code_REGEX = /\A\d{3}[-]\d{4}\z/.freeze
  VALID_phone_number_REGEX = /\A\d{10,11}\z/.freeze

  with_options presence: true do
    validates :postal_code, format: { with: VALID_postal_code_REGEX }
    validates :area_id, numericality: { other_than: 0, message: 'Select' }
    validates :city
    validates :house_number
    validates :phone_number, format: { with: VALID_phone_number_REGEX }
  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(purchase_id: purchase.id, postal_code: postal_code, area_id: area_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number )
  end

end


# def new
#   @donation = User.new
# end

# def create
#   @donation = User.create(donation_params)
# end

# private

# def donation_params
#   params.require(:user).permit(:name, :name_reading, :nickname)
# end

# # purchase = Purchase.new(item_id: item_id, user_id: user_id)
# # purchase.save
# Address.create(purchase_id: purchase.id, postal_code: postal_code, area_id: area_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number )
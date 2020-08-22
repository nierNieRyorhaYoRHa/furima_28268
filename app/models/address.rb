class Address < ApplicationRecord

  VALID_postal_code_REGEX = /\A\d{3}[-]\d{4}\z/.freeze
  VALID_phone_number_REGEX = /\A\d{10,11}\z/.freeze

  with_options presence: true do
    validates :postal_code, format: { with: VALID_postal_code_REGEX }
    validates :area_id, numericality: { other_than: 0, message: 'Select' }
    validates :city
    validates :house_number
    validates :phone_number, format: { with: VALID_phone_number_REGEX }
  end

  belongs_to :purchace, optional: true
end
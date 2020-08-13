class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

VALID_email_REGEX = /\A\S+@\S+\.\S+\z/
VALID_password_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,100}\z/i
VALID_name_REGEX = /\A[ぁ-んァ-ン一-龥]/
VALID_name_kana_REGEX = /\A[ァ-ヶー－]+\z/


  with_options presence: true do
    validates :nickname
    validates :email, format: { with: VALID_email_REGEX }
    validates :encrypted_password, format: { with: VALID_password_REGEX }
    validates :last_name, format: { with: VALID_name_REGEX }
    validates :first_name, format: { with: VALID_name_REGEX }
    validates :last_name_kana, format: { with: VALID_name_kana_REGEX }
    validates :first_name_kana, format: { with: VALID_name_kana_REGEX }
    validates :birthday
  end

end

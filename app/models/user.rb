class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_email_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze
  VALID_password_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,100}\z/i.freeze
  VALID_name_REGEX = /\A[ぁ-んァ-ン一-龥]/.freeze
  VALID_name_kana_REGEX = /\A[ァ-ヶー－]+\z/.freeze

  with_options presence: true do
    validates :nickname
    validates :email, format: { with: VALID_email_REGEX }
    validates :password, format: { with: VALID_password_REGEX }
    validates :last_name, format: { with: VALID_name_REGEX }
    validates :first_name, format: { with: VALID_name_REGEX }
    validates :last_name_kana, format: { with: VALID_name_kana_REGEX }
    validates :first_name_kana, format: { with: VALID_name_kana_REGEX }
    validates :birthday
  end
end

# encrypted_passwordは暗号化されたパスワード、これにバリデーションをかけても意味がない

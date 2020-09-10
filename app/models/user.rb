class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  VALID_email_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze
  VALID_password_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,100}\z/i.freeze
  VALID_name_REGEX = /\A[ぁ-んァ-ン一-龥]/.freeze
  VALID_name_kana_REGEX = /\A[ァ-ヶー－]+\z/.freeze

  with_options presence: true do
    validates :nickname
    validates :email, format: { with: VALID_email_REGEX }
    # validates :password, format: { with: VALID_password_REGEX }
    validates :last_name, format: { with: VALID_name_REGEX }
    validates :first_name, format: { with: VALID_name_REGEX }
    validates :last_name_kana, format: { with: VALID_name_kana_REGEX }
    validates :first_name_kana, format: { with: VALID_name_kana_REGEX }
    validates :birthday
  end

  has_many :items
  has_many :purchases
  has_many :comments
  has_one :card, dependent: :destroy
  has_many :sns_credentials

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end

end

# encrypted_passwordは暗号化されたパスワード、これにバリデーションをかけても意味がない

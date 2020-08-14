require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー管理機能' do
    context 'ユーザー情報' do
      it "ニックネームが必須であること" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "メールアドレスが必須であること" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "メールアドレスが一意性であること" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "メールアドレスは@を含む必要があること" do
        @user.email = 'aaabbb'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "パスワードが必須であること" do
        @user.password = ""
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "パスワードは6文字以上であること" do
        @user.password = "12345"
        @user.password_confirmation = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "パスワードは半角英数字混合であること" do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it "パスワードは確認用を含めて2回入力すること" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end

    context '本人情報確認' do
      it "ユーザー本名が、名字と名前がそれぞれ必須であること" do
        @user.last_name = ''
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name is invalid")
      end
      it "ユーザー本名は全角（漢字・ひらがな・カタカナ）で入力させること" do
        @user.last_name = 'a'
        @user.first_name = 'b'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid", "First name is invalid")
      end
      it "ユーザー本名のフリガナが、名字と名前でそれぞれ必須であること" do
        @user.last_name_kana = ''
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid", "First name kana can't be blank")
      end
      it "ユーザー本名のフリガナは全角（カタカナ）で入力させること" do
        @user.last_name_kana = 'a'
        @user.first_name_kana = 'い'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid", "First name kana is invalid")
      end
      it "生年月日が必須であること" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
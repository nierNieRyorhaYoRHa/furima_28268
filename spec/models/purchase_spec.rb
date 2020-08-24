require 'rails_helper'

RSpec.describe ItemPurchase, type: :model do
  before do
    @purchase = FactoryBot.build(:item_purchase)
  end

  describe '商品購入機能' do
    context 'クレジットカード情報入力' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase).to be_valid
      end
      it 'クレジットカード情報入力が必須であること' do
        @purchase.token = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Token can't be blank")
      end
    end

    context '配送先入力' do
      it '配送先の情報として、郵便番号が必須であること' do
        @purchase.postal_code = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号にはハイフンが必要であること（123-4567となる）' do
        @purchase.postal_code = '1234567'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Postal code is invalid')
      end
      it '配送先の情報として、都道府県が必須であること' do
        @purchase.area_id = 0
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Area Select')
      end
      it '配送先の情報として、市区町村が必須であること' do
        @purchase.city = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("City can't be blank")
      end
      it '配送先の情報として、番地が必須であること' do
        @purchase.house_number = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("House number can't be blank")
      end
      it '配送先の情報として、建物名は必須ではないこと' do
        @purchase.building_name = nil
        expect(@purchase).to be_valid
      end
      it '配送先の情報として、電話番号が必須であること' do
        @purchase.phone_number = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にはハイフンは不要であること' do
        @purchase.phone_number = '012-3456-7890'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号は11桁以内であること' do
        @purchase.phone_number = '0123456789012'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end

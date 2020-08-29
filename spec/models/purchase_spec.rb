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
        @purchase.card_token = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('カード情報を入力してください')
      end
    end

    context '配送先入力' do
      it '配送先の情報として、郵便番号が必須であること' do
        @purchase.postal_code = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('郵便番号を入力してください')
      end
      it '郵便番号にはハイフンが必要であること（123-4567となる）' do
        @purchase.postal_code = '1234567'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '配送先の情報として、都道府県が必須であること' do
        @purchase.area_id = 0
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('都道府県を選択してください')
      end
      it '配送先の情報として、市区町村が必須であること' do
        @purchase.city = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('市区町村を入力してください')
      end
      it '配送先の情報として、番地が必須であること' do
        @purchase.house_number = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('番地を入力してください')
      end
      it '配送先の情報として、建物名は必須ではないこと' do
        @purchase.building_name = nil
        expect(@purchase).to be_valid
      end
      it '配送先の情報として、電話番号が必須であること' do
        @purchase.phone_number = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('電話番号を入力してください')
      end
      it '電話番号にはハイフンは不要であること' do
        @purchase.phone_number = '012-3456-7890'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('電話番号は不正な値です')
      end
      it '電話番号は11桁以内であること' do
        @purchase.phone_number = '0123456789012'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('電話番号は不正な値です')
      end
    end
  end
end

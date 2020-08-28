require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.images.attach(fixture_file_upload('public/images/test_image.png'))
  end

  describe '商品出品機能' do
    context '実装の条件' do
      it '画像は1枚必須であること' do
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it '商品名が必須であること' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品の説明が必須であること' do
        @item.explanation = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品説明を入力してください")
      end
      it 'カテゴリーの情報が必須であること' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it '商品の状態についての情報が必須であること' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      it '配送料の負担についての情報が必須であること' do
        @item.delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end
      it '発送元の地域についての情報が必須であること' do
        @item.area_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('配送元の地域を選択してください')
      end
      it '発送までの日数についての情報が必須であること' do
        @item.days_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
      it '価格についての情報が必須であること' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end
      it '価格の範囲が、¥300以上であること' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は300以上の値にしてください')
      end
      it '価格の範囲が、¥9,999,999以下であること' do
        @item.price = 19_999_999
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は9999999以下の値にしてください')
      end
    end
  end
end

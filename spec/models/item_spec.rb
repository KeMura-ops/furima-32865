require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品機能' do
    context '商品出品が成功するとき' do
      it '全ての項目が存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品が失敗するとき' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'item_descが空では出品できない' do
        @item.item_desc = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("説明文を入力してください")
      end
      it 'categoryが選択されていないと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリー(種類)は1以外の値にしてください")
      end
      it 'conditionが選択されていないと出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態は1以外の値にしてください")
      end
      it 'delivery_feeが選択されていないと出品できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担は1以外の値にしてください")
      end
      it 'delivery_areaが選択されていないと出品できない' do
        @item.delivery_area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域は1以外の値にしてください")
      end
      it 'delivery_timeが選択されていないと出品できない' do
        @item.delivery_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日時は1以外の値にしてください")
      end
      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end
      it 'priceが全角数字だと出品できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格が設定額の範囲外です")
      end
      it 'priceが300未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格が設定額の範囲外です")
      end
      it 'priceが9999999よりも高いと出品できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格が設定額の範囲外です")
      end
      it 'userが存在していなければ保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end

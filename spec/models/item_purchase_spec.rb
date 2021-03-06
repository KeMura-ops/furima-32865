require 'rails_helper'

RSpec.describe ItemPurchase, type: :model do
  before do
    @item = FactoryBot.build(:item)
        @item.save
        @user = FactoryBot.build(:user)
        @user.save
        @item_purchase = FactoryBot.build(:item_purchase, item_id: @item.id, user_id: @user.id)
        sleep 0.1 # Mysqlエラー対策のため記述
  end

  describe '商品購入機能' do
    context '商品の購入に成功するとき' do
      it '全ての項目が存在すれば商品を購入できる' do
        expect(@item_purchase).to be_valid
      end
      it 'building_nameが空でも購入できる' do
        @item_purchase.building_name = ''
        expect(@item_purchase).to be_valid
      end
    end

    context '商品購入ができない場合' do
      it 'user_idが存在していないと保存できない' do
        @item_purchase.user_id = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Userを入力してください")
      end
      it 'item_idが存在していないと保存できない' do
        @item_purchase.item_id = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Itemを入力してください")
      end
      it 'tokenが存在していないと購入できない' do
        @item_purchase.token = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("カード情報を入力してください")
      end
      it 'postal_codeが空では保存できない' do
        @item_purchase.postal_code = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postal_codeにハイフンが存在していないと保存できない' do
        @item_purchase.postal_code = '1234567'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'delivery_area_id(都道府県)が1では保存できない' do
        @item_purchase.delivery_area_id = 1
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("都道府県は1以外の値にしてください")
      end
      it 'municipality(市区町村)が空では保存できない' do
        @item_purchase.municipality = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'street_address(番地)が空では保存できない' do
        @item_purchase.street_address = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空では保存できない' do
        @item_purchase.phone_number = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_numberが12桁以上では保存できない' do
        @item_purchase.phone_number = '090123456789'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberが半角数字で入力されていないと保存できない' do
        @item_purchase.phone_number = '０９０１２３４５６７８'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("電話番号は不正な値です")
      end
    end
  end
end
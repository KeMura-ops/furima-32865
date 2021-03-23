class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :user_match, only: [:index, :create]

  def index
    @item_purchase = ItemPurchase.new
  end

  def create
    @item_purchase = ItemPurchase.new(order_params)
    if @item_purchase.valid?
      pay_item
      @item_purchase.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:item_purchase).permit(:postal_code, :delivery_area_id, :municipality, :street_address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # テスト用秘密鍵
    Payjp::Charge.create(
      amount: @item.price,                  # @itemに格納された商品の値段
      card: order_params[:token],           # 生成されたトークン
      currency: 'jpy'                       # 通貨の種類(日本円)
    )
  end

  def user_match
    if @item.user.id == current_user.id || @item.order
      redirect_to root_path
    end
  end
end

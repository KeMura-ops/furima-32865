class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]

  def index
    @item_purchase = ItemPurchase.new
  end

  def create
    
  end

  private

  def order_params
    params.require(:item_purchase).permit(:postal_code, :delivery_area_id, :municipality, :street_address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end

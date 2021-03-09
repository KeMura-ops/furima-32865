class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.required(:item).permit(:image, :name, :item_desc, :category_id, :condition_id, :delivery_fee_id, :delivery_area_id, :delivery_time_id, :price).merge(user_id: current_user.id)
  end
end

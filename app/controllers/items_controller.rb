class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
  end

  private
  def tweet_params
    params.require(:item).permit(:image, :name, :explanation, :price, :user, :category_id, :status_id, :delivery_id, :area_id, :days_id)
  end

end



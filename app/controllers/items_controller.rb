class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show]
  before_action :move_to_sign_in, except: [:index, :show]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = ItemTag.new
  end

  def create
    @item = ItemTag.new(item_params)
    if @item.save
      redirect_to root_path(@item)
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user).order('created_at DESC')
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to root_path(@item)
    else
      render :edit
    end
  end

  def search
    return nil if params[:input] == ''

    tag = Tag.where(['brand LIKE ?', "%#{params[:input]}%"])
    render json: { keyword: tag }
  end

  private

  def item_params
    params.require(:item_tag).permit(:name, :explanation, :category_id, :status_id, :delivery_id, :area_id, :days_id, :price, :brand, images: []).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_sign_in
    redirect_to user_session_path unless user_signed_in?
  end
end

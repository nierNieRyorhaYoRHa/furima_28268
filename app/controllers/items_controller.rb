class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show]
  before_action :move_to_sign_in, except: [:index, :show, :item_search]
  before_action :searches_tag, only: [:index, :item_search, :brand, :category]
  before_action :searches_item, only: [:index, :item_search, :brand, :category]

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

  def brand
    @tags = Tag.order('created_at DESC')
    @items = Item.includes(:user).order('created_at DESC')
    set_item_column
  end

  def category
    @tags = Tag.order('created_at DESC')
    @items = Item.includes(:user).order('created_at DESC')
    set_item_column
  end

  def item_search
    @results = @p2.result.includes(:user)  # 検索条件にマッチした商品の情報を取得
  end

  def tag_search
    @results = @p.result.includes(:item)  # 検索条件にマッチした商品の情報を取得
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

  def searches_tag
    @p = Tag.ransack(params[:q])  # 検索オブジェクトを生成
  end

  def searches_item
    @p2 = Item.ransack(params[:q])
  end

  def set_item_column
    @item_category = Item.select("category_id").distinct  # 重複なくnameカラムのデータを取り出す
  end

end

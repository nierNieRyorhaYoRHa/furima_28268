class PurchasesController < ApplicationController
  before_action :move_to_sign_in
  before_action :move_to_root

  def index
    @address = Address.new
    @item = Item.find(params[:item_id])
    @purchase = ItemPurchase.new(purchase_params)
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase = ItemPurchase.new(purchase_params)
    if @purchase.valid?
      @purchase.save
      pay_item
      redirect_to root_path and return
    else
      render :index and return
    end
    
  end

  private

  def move_to_sign_in
    redirect_to user_session_path unless user_signed_in?
  end

  def move_to_root
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id
  end

  def move_to_root
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id
  end

  def purchase_params
    #「住所」「寄付金」のキーも追加
    params.permit(:token, :item_id, :postal_code, :area_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: purchase_params[:token],    # カードトークン
      currency:'jpy'                 # 通貨の種類(日本円)
    )
  end

end


# class PurchasesController < ApplicationController

#   def index
#     @address = Address.new
#     @item = Item.find(params[:item_id])
#   end


#   def create
#     @item = Item.find(params[:item_id])
#     @purchase = Purchase.new(purchase_params)
#     @address = Address.new(address_params)
#     if @purchase.save
#       @address.purchase_id = @purchase.id
#       if @address.save
#         redirect_to root_path and return
#       else
#         render :index and return
#       end
#     else
#       render :index and return
#     end
    
#   end



#   private

#   def move_to_index
#     redirect_to user_session_path unless user_signed_in?
#   end

#   def purchase_params
#     #「住所」「寄付金」のキーも追加
#     params.permit(:item_id).merge(user_id: current_user.id)
#   end

#   def address_params
#     #「住所」「寄付金」のキーも追加
#     params.require(:address).permit(:postal_code, :area_id, :city, :house_number, :building_name, :phone_number)
#   end

# end

class PurchasesController < ApplicationController

  def index
    @address = Address.new
    @item = Item.find(params[:item_id])
  end


  def create
    @item = Item.find(params[:item_id])
    @purchase = ItemPurchase.new(purchase_params)
    if @purchase.save
      redirect_to root_path and return
    else
      render :index and return
    end
    
  end



  private

  def move_to_index
    redirect_to user_session_path unless user_signed_in?
  end

  def purchase_params
    #「住所」「寄付金」のキーも追加
    params.permit(:item_id, :postal_code, :area_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id)
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

class CardsController < ApplicationController
  before_action :card_params, only: [:new, :create, :destroy]
  before_action :set_card

  def new
    @user = User.find(current_user.id)
  end

  def create
    @user = User.find(current_user.id)
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    customer = Payjp::Customer.create(
    description: 'test', # テストカードであることを説明
    card: params[:card_token] # 登録しようとしているカード情報
    )

    card = Card.new( # トークン化されたカード情報を保存する
    card_token: params[:card_token], # カードトークン
    customer_token: customer.id, # 顧客トークン
    user_id: current_user.id # ログインしているユーザー
  )
    if card.save
      redirect_to user_path(current_user)
    else
      render "new" # カード登録画面
    end
  end

  def destroy
    @user = User.find(current_user.id)
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    customer = Payjp::Customer.retrieve(@card.customer_token)
    customer.delete

    if @card.destroy #削除に成功した時にポップアップを表示します。
      redirect_to action: "new"
    else #削除に失敗した時にアラートを表示します。
      redirect_to action: "new"
    end

  end


  private


  def card_params
    params.permit(:card_token, :user_id)
  end

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

end
